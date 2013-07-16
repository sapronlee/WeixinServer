EasyCaptcha.setup do |config|
  # Cache
  config.cache          = true
  # Cache temp dir from Rails.root
  config.cache_temp_dir = Rails.root + 'tmp' + 'captchas'
  # Cache size
  config.cache_size     = 10
  # Cache expire
  config.cache_expire   = 1.minutes

  # Chars
  config.chars          = %w(2 3 4 5 6 7 9 A C D E F G H J K L M N P Q R S T U X Y Z)

  # Length
  config.length         = 6

  # Image
  config.image_height   = 30
  config.image_width    = 90

  # eSpeak
  # config.espeak do |espeak|
    # Amplitude, 0 to 200
    # espeak.amplitude = 80..120

    # Word gap. Pause between words
    # espeak.gap = 80

    # Pitch adjustment, 0 to 99
    # espeak.pitch = 30..70

    # Use voice file of this name from espeak-data/voices
    # espeak.voice = nil
  # end

  # configure generator
  config.generator :default do |generator|

    # Font
    generator.font_size              = 24
    generator.font_fill_color        = '#333333'
    generator.font_stroke_color      = '#000000'
    generator.font_stroke            = 0
    # generator.font_family            = File.expand_path('../../resources/afont.ttf', __FILE__)

    generator.image_background_color = 'none'

    # Wave
    # generator.wave                   = true
    # generator.wave_length            = (60..100)
    # generator.wave_amplitude         = (3..5)

    # Sketch
    generator.sketch                 = false
    # generator.sketch_radius          = 0
    # generator.sketch_sigma           = 0.5

    # Implode
    # generator.implode                = 0.1

    # Blur
    generator.blur                   = false
    # generator.blur_radius            = 1
    # generator.blur_sigma             = 2
  end
end
