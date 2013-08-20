module Mongoid
  module Uploader

    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods

      # @overload uploader(field, uploader = nil, options = {}, &block)
      #   上传一个文件
      #   @param [field] 指定字段
      #   @param [uploader] 上传器
      #   @param [Hash] options
      #   @param options [Integer] :size 上传文件的大小,默认为0.5(512KB).
      #   @param options [Boolean] :presence 是否必填,默认为true.
      #   @param options [Boolean] :dimensions 是否带图片的尺寸,默认为false,如果为true,会创建[field]_width,[field]_height.
      #   @yield If given, 一个block.
      #
      # @example A custom builder
      #   class Person
      #     include Mongoid::Document
      #     include Mongoid::UploadImage
      #
      #     uploader_image :image, ImageUploader, dimensions: true, size: 10, presence: false
      #   end
      #
      def uploader field, uploader = nil, options = {}, &block
        options.merge!({ duration: false })
        uploader_resource field, uploader, options, &block
      end


      # @overload uploader_media(field, uploader = nil, options = {}, &block)
      #   上传一个媒体文件
      #   @param [field] 指定字段
      #   @param [uploader] 上传器
      #   @param [Hash] options
      #   @param options [Integer] :size 上传文件的大小,默认为0.5(512KB).
      #   @param options [Boolean] :presence 是否必填,默认为true.
      #   @param options [Boolean] :duration 记录时长
      #   @yield If given, 一个block.
      #
      # @example A custom builder
      #   class Person
      #     include Mongoid::Document
      #     include Mongoid::UploadImage
      #
      #     uploader_media :video, VideoUploader, size: 10
      #   end
      #
      def uploader_media field, uploader = nil, options = {}, &block
        options.merge!({ dimensions: false })

        is_presence = options.fetch(:presence, true)

        field "#{field}_desc".to_sym,   type: String
        field "#{field}_name".to_sym,   type: String
        field "#{field}_lyric".to_sym,  type: String

        # 验证
        validates "#{field}_name".to_sym, "#{field}_desc".to_sym, "#{field}_lyric".to_sym, presence: true if is_presence
        validates "#{field}_name".to_sym, length: { within: 2..15 }, unless: ->(m) { m.send("#{field}_name").blank? }
        validates "#{field}_desc".to_sym, length: { within: 2..140 }, unless: ->(m) { m.send("#{field}_desc").blank? }
        validates "#{field}_lyric".to_sym, length: { within: 2..5000 }, unless: ->(m) { m.send("#{field}_lyric").blank? }

        uploader_resource field, uploader, options, &block
      end

      private
      def uploader_resource field, uploader = nil, options = {}, &block
        # 默认值
        # 上传文件大小
        size = options.fetch(:size, 0.5)
        # 是否必填
        is_presence = options.fetch(:presence, true)
        # 保存尺寸
        is_dimensions = options.fetch(:dimensions, true)
        # 保存时长
        is_duration = options.fetch(:duration, true)

        # CarrierWave
        mount_uploader field, uploader, options, &block

        # 添加size和type,无论是图片，视频，音频都要添加
        field "#{field}_size".to_sym,       type: Integer, default: 0
        field "#{field}_type".to_sym,       type: String

        if is_dimensions
          field "#{field}_width".to_sym,    type: Integer, default: 0
          field "#{field}_height".to_sym,   type: Integer, default: 0
        end

        if is_duration
          field "#{field}_duration".to_sym, type: Float, default: 0.0
        end

        # 验证
        validates field.to_sym, file_size: { maximum: size.megabytes.to_i }
        validates field.to_sym, presence: true if is_presence

        set_callback(:save, :before) do |document|
          if document.send("#{field}").present? && document.send("#{field}_changed?")
            # 更新type和size
            document.send("#{field}_type=", MIME::Types.type_for(document.send("#{field}").file.original_filename).first.to_s)
            document.send("#{field}_size=", document.send("#{field}").file.size)
            document.send("#{field}_name=", document.send("#{field}").file.filename)
            # 更新尺寸
            if is_dimensions
              width, height = `identify -format "%wx%h" #{document.send("#{field}").path}`.split(/x/)
              document.send("#{field}_width=", width)
              document.send("#{field}_height=", height)
            end
            # 更新时长
            if is_duration
              document.send("#{field}_duration=", document.send("#{field}").info.duration)
            end
          end
        end

      end

    end

  end # => UploadImage
end # => Mongoid