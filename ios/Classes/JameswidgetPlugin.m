#import "JameswidgetPlugin.h"
#if __has_include(<jameswidget/jameswidget-Swift.h>)
#import <jameswidget/jameswidget-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "jameswidget-Swift.h"
#endif

@implementation JameswidgetPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftJameswidgetPlugin registerWithRegistrar:registrar];
}
@end
