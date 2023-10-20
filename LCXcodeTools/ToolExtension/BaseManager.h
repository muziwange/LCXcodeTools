//
//  BaseManager.h
//  ToolExtension
//
//  Created by 李成 on 2023/7/15.
//

#import <Foundation/Foundation.h>
#import <XcodeKit/XcodeKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseManager : NSObject

+ (void)startInvocation:(XCSourceEditorCommandInvocation *)invocation;

@end

NS_ASSUME_NONNULL_END
