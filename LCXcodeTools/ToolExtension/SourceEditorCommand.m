//
//  SourceEditorCommand.m
//  ToolExtension
//
//  Created by 李成 on 2023/7/13.
//

#import "SourceEditorCommand.h"
#import "BaseManager.h"

@implementation SourceEditorCommand

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler
{
    // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
    
    NSDictionary *dic = [self.class clsIndentifiMap];
    NSString *clsName = dic[invocation.commandIdentifier];
    if (clsName && [NSClassFromString(clsName) respondsToSelector:@selector(startInvocation:)]) {
        [NSClassFromString(clsName) performSelector:@selector(startInvocation:) withObject:invocation];
    }
    
    completionHandler(nil);
}

static NSDictionary *_lcMap = nil;
+ (NSDictionary *)clsIndentifiMap {
    if (!_lcMap) {
        _lcMap = @{
            @"lcDeleteEmptyLines" : @"DeleteEmptyLinesManager",
            @"lcMergeCode" : @"ShellManager",
            @"lcIMportHeader" : @"ImprotManager",
        };
    }
    return _lcMap;
}

@end
