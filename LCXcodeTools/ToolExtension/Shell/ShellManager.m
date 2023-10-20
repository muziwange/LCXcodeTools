//
//  ShellManager.m
//  ToolExtension
//
//  Created by 李成 on 2023/7/14.
//

#import "ShellManager.h"
#import <AppKit/AppKit.h>

@implementation ShellManager

+ (void)startInvocation:(XCSourceEditorCommandInvocation *)invocation {
//    // 获取脚本路径
//    NSBundle *mainBundle = [NSBundle mainBundle];
//    NSString *projectPath = [mainBundle.bundlePath stringByDeletingLastPathComponent];
//    NSString *projectRootPath = projectPath.stringByDeletingLastPathComponent;
//    NSString *projectFilePath = [projectRootPath stringByAppendingPathComponent:@"project.pbxproj"];
    
//    NSString *path = [[NSWorkspace sharedWorkspace] URLForApplicationWithBundleIdentifier:@"com.lc.LCXcodeTools.ToolExtension11"].absoluteString;
    
//    // 构建项目
//    NSTask *buildTask = [[NSTask alloc] init];
//    [buildTask setLaunchPath:@"/usr/bin/xcodebuild"];
//    [buildTask setCurrentDirectoryPath:projectPath];
//    [buildTask setArguments:@[@"-workspace", @"MyApp.xcworkspace", @"-scheme", @"MyApp", @"-configuration", @"Release", @"-derivedDataPath", @"build"]];
//    [buildTask launch];
//    [buildTask waitUntilExit];
//
//    NSError *error;
//    // 部署项目
//    NSString *buildFolderPath = [projectPath stringByAppendingPathComponent:@"build/Build/Products/Release"];
//    NSString *ipaPath = [buildFolderPath stringByAppendingPathComponent:@"MyApp.ipa"];
//    [NSFileManager.defaultManager copyItemAtPath:ipaPath toPath:@"/path/to/deploy" error:&error];
//    NSLog(@"error: %@",error);
    
//    NSTask *task = [[NSTask alloc] init];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSOpenPanel *openPanel = [NSOpenPanel openPanel];
        [openPanel setCanChooseDirectories:YES];
        [openPanel setCanCreateDirectories:YES];
        [openPanel setAllowsMultipleSelection:NO];
        
        if ([openPanel runModal] == NSModalResponseOK) {
            NSArray *urls = [openPanel URLs];
            NSString *path = [[urls objectAtIndex:0] path];
            // 使用所选文件夹路径
        }
    });
}


@end
