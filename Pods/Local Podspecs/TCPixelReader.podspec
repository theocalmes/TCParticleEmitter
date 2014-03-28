Pod::Spec.new do |s|
  s.name = 'TCPixelReader'
  s.version = '0.0.1'
  s.summary = 'Read the pixels from an image.'

  s.description = <<-DESC
                   A lightweight pod for acessing pixel values on an image.
                  DESC

  s.license = 'MIT'
  s.homepage = 'https://github.com/theocalmes/TCPixelReader'
  s.authors = 'Theodore Calmes'

  s.ios.deployment_target = '7.0'
  s.osx.deployment_target = '10.9'

  s.source = { :git => 'https://github.com/theocalmes/TCPixelReader.git', :tag => s.version.to_s }

  s.source_files = 'TCPixelReader'
  s.requires_arc = true
end
