Pod::Spec.new do |s|

    s.name = 'FFExtension'
    s.version = '1.1.4'
    s.platform = :ios, '8.0'
    s.ios.deployment_target = '8.0'
    s.license = 'MIT'
    s.homepage = 'https://github.com/kobe1941/FFExtension'
    s.author = { 'hufeng' => 'fenng.hu@qq.com' }
    s.source = { :git => 'https://github.com/kobe1941/FFExtension.git', :tag => s.version }
    s.summary = 'To reduce the crash in ios app'
    s.description = 'if you have any problem or crash with use FFExtension, please issue me and paste detail crash logs,  Have a nice day(#^.^#).'
    s.requires_arc = true
    s.source_files = 'FFExtension/Classes/*.{h,m}'

    non_arc_files = 'FFExtension/Classes/MRC/*.{h,m}'
    s.exclude_files = non_arc_files
    s.subspec 'MRC' do |sp|
        sp.source_files = non_arc_files
        sp.requires_arc = false
    end
end
