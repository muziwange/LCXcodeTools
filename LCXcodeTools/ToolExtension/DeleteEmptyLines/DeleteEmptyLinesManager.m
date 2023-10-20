//
//  DeleteEmptyLinesManager.m
//  ToolExtension
//
//  Created by 李成 on 2023/7/13.
//

#import "DeleteEmptyLinesManager.h"

@implementation DeleteEmptyLinesManager


+ (void)startInvocation:(XCSourceEditorCommandInvocation *)invocation {
    XCSourceTextBuffer *buf = invocation.buffer;
    for (XCSourceTextRange *range in buf.selections) {
        NSMutableArray *delLines = [[NSMutableArray alloc] init];
        for (NSInteger idx = [self startLine:range]; idx < [self endLine:range]; idx ++) {
            NSString *line = buf.lines[idx];
            NSRange range = [line rangeOfString:@"^\\s*$" options:NSRegularExpressionSearch];
            if (range.location != NSNotFound) {
                [delLines addObject:line];
            }
        }
        [buf.lines removeObjectsInArray:delLines];
    }
}

+ (NSInteger)startLine:(XCSourceTextRange *)range {
    return range.start.line;
}

+ (NSInteger)endLine:(XCSourceTextRange *)range {
    return range.end.line;
}

@end
