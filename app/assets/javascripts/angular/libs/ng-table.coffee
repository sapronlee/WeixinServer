"use strict"

###
ngTable: Table + Angular JS

@author Vitalii Savchuk <esvit666@gmail.com>
@copyright 2013 Vitalii Savchuk <esvit666@gmail.com>
@version 0.2.1
@url https://github.com/esvit/ng-table/
@license New BSD License <http://creativecommons.org/licenses/BSD/>
###

angular.module("ngTable", []).directive("ngTable", ["$compile", "$q", "$parse", "$http", "ngTableParams", ($compile, $q, $parse, $http, ngTableParams) ->
  restrict: "A"
  priority: 1001
  scope: true
  controller: [ "$scope", "$timeout", ($scope, $timeout) ->
    $scope.params = $scope.params or
      page: 1
      count: 10

    # update result every time when chenge filters
    $scope.$watch('params.filter', ((value) ->
      if $scope.params.$liveFiltering
        updateParams value
        $scope.goToPage 1
    ), true)

    updateParams = (newParams) ->
      newParams = angular.extend($scope.params, newParams)

      # assign params in both scopes
      $scope.paramsModel.assign $scope.$parent, new ngTableParams(newParams)
      $scope.params = angular.copy(newParams)

    # goto page
    $scope.goToPage = (page) ->
      updateParams page: page  if page > 0 and $scope.params.page isnt page and $scope.params.count * (page - 1) <= $scope.params.total

    # change items per page
    $scope.changeCount = (count) ->
      updateParams
        page: 1
        count: count


    $scope.doFilter = ->
      updateParams page: 1

    $scope.sortBy = (column) ->
      return  unless column.sortable
      sorting = $scope.params.sorting and $scope.params.sorting[column.sortable] and ($scope.params.sorting[column.sortable] is "desc")
      sortingParams = {}
      sortingParams[column.sortable] = (if sorting then "asc" else "desc")
      updateParams sorting: sortingParams
  ]
  compile: (element, attrs) ->
    i = 0
    columns = []
    angular.forEach element.find("td"), (item) ->
      el = $(item)
      if (el.attr("ignore-cell") && "true" == el.attr("ignore-cell"))
        return
      parsedTitle = $parse(el.attr("title"))
      columns.push
        id: i++
        title: parsedTitle() or el.attr("title") or el.text()
        sortable: (if el.attr("sortable") then el.attr("sortable") else false)
        filter: (if el.attr("filter") then $parse(el.attr("filter"))() else false)
        filterData: (if el.attr("filter-data") then el.attr("filter-data") else null)


    (scope, element, attrs) ->
      scope.columns = columns
      # generate array of pages
      generatePages = (currentPage, totalItems, pageSize) ->
        maxBlocks = 11
        pages = []
        numPages = Math.ceil(totalItems / pageSize)
        if numPages > 1
          pages.push
            type: "prev"
            number: Math.max(1, currentPage - 1)
            active: currentPage > 1

          pages.push
            type: "first"
            number: 1
            active: currentPage > 1

          maxPivotPages = Math.round((maxBlocks - 5) / 2)
          minPage = Math.max(2, currentPage - maxPivotPages)
          maxPage = Math.min(numPages - 1, currentPage + maxPivotPages * 2 - (currentPage - minPage))
          minPage = Math.max(2, minPage - (maxPivotPages * 2 - (maxPage - minPage)))
          i = minPage

          while i <= maxPage
            if (i is minPage and i isnt 2) or (i is maxPage and i isnt numPages - 1)
              pages.push type: "more"
            else
              pages.push
                type: "page"
                number: i
                active: currentPage isnt i

            i++
          pages.push
            type: "last"
            number: numPages
            active: currentPage isnt numPages

          pages.push
            type: "next"
            number: Math.min(numPages, currentPage + 1)
            active: currentPage < numPages

        pages

      # update pagination where parameters changes
      scope.$parent.$watch attrs.ngTable, ((params) ->
        return  if angular.isUndefined(params)
        scope.paramsModel = $parse(attrs.ngTable)
        scope.pages = generatePages(params.page, params.total, params.count)
        scope.params = angular.copy(params)
      ), true

      # show/hide filter row
      if attrs.showFilter
        scope.$parent.$watch attrs.showFilter, (value) ->
          scope.show_filter = value

      # get data from columns
      angular.forEach columns, (column) ->
        return  unless column.filterData
        promise = $parse(column.filterData)(scope, $column: column)
        throw new Error("Function " + column.filterData + " must be promise")  unless (angular.isObject(promise) && angular.isFunction(promise.then))
        delete column["filterData"]

        promise.then (data) ->
          data = []  unless angular.isArray(data)
          data.unshift title: "-", id: ""
          column.data = data

      # create table
      unless element.hasClass("ng-table")
        scope.templates =
          header: (if attrs.templateHeader then attrs.templateHeader else "ng-table/header.html")
          pagination: (if attrs.templatePagination then attrs.templatePagination else "ng-table/pager.html")

        headerTemplate = $compile("<thead ng-include=\"templates.header\"></thead>")(scope)
        paginationTemplate = $compile("<div ng-include=\"templates.pagination\"></div>")(scope)
        element.filter("thead").remove()
        element.prepend(headerTemplate).addClass "ng-table"
        element.after paginationTemplate
])

angular.module('ngTable').run(['$templateCache', ($templateCache)->
	$templateCache.put('ng-table/filters/button.html', '<button ng-click="doFilter()" ng-show="filter==\'button\'" class="btn btn-primary btn-small btn-block">Filter</button>');
	$templateCache.put('ng-table/filters/select.html', '<select ng-options="data.id as data.title for data in column.data" ng-model="params.filter[name]" ng-show="filter==\'select\'" class="filter filter-select"></select>');
	$templateCache.put('ng-table/filters/text.html', '<input type="text" ng-model="params.filter[name]" ng-show="filter==\'text\'" class="input-filter"/>');
	$templateCache.put('ng-table/header.html', '<tr><th ng-class="{sortable: column.sortable,\'sort-asc\': params.sorting[column.sortable]==\'asc\', \'sort-desc\': params.sorting[column.sortable]==\'desc\'}" ng-click="sortBy(column)" ng-repeat="column in columns" class="header"><div>{{column.title}}</div></th></tr><tr ng-show="show_filter"><th ng-repeat="column in columns" class="filter"><form ng-submit="doFilter()"><input type="submit" style="position: absolute; left: -9999px; width: 1px; height: 1px;"/><div ng-repeat="(name, filter) in column.filter"><div ng-include="\'ng-table/filters/\' + filter + \'.html\'"></div></div></form></th></tr>');
	$templateCache.put('ng-table/pager.html', '<div class="table-footer clearfix"><div class="pagination pull-left"><ul class="ng-cloak"><li ng-class="{\'disabled\': !page.active}" ng-repeat="page in pages" ng-switch="page.type"><a ng-switch-when="prev" ng-click="goToPage(page.number)" href="">«</a><a ng-switch-when="first" ng-click="goToPage(page.number)" href="">{{page.number}}</a><a ng-switch-when="page" ng-click="goToPage(page.number)" href="">{{page.number}}</a><a ng-switch-when="more" ng-click="goToPage(page.number)" href="">…</a><a ng-switch-when="last" ng-click="goToPage(page.number)" href="">{{page.number}}</a><a ng-switch-when="next" ng-click="goToPage(page.number)" href="">»</a></li></ul></div><div ng-show="params.counts.length" class="btn-group pull-right"><button ng-repeat="count in params.counts" type="button" ng-class="{\'active\':params.count==count}" ng-click="changeCount(count)" class="btn btn-small btn-primary">{{count}}</button></div></div>');
])