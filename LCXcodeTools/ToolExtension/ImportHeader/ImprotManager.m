//
//  ImprotManager.m
//  ToolExtension
//
//  Created by 李成 on 2023/7/15.
//

#import "ImprotManager.h"

@implementation ImprotManager

+ (void)startInvocation:(XCSourceEditorCommandInvocation *)invocation {
    XCSourceTextBuffer *buf = invocation.buffer;
    NSArray *selects = buf.selections;
    if (selects.count < 1) return;
    XCSourceTextRange *range = buf.selections.firstObject;
    NSInteger startLine = range.start.line;
    NSInteger endLine = range.end.line;
    NSInteger startIndex = range.start.column;
    NSInteger endIndex = range.end.column;
    if (startLine == endLine && startIndex == endIndex) return;
    NSString *content;
    if (startLine == endLine) {
        content = buf.lines[startLine];
    } else {
        NSMutableString *tmp = [[NSMutableString alloc] init];
        for (NSInteger idx = startLine; idx <= endLine; idx++) {
            [tmp appendString:buf.lines[idx]];
        }
        content = tmp;
    }
    NSString *selContent = [content substringWithRange:NSMakeRange(startIndex, endIndex-startIndex)];
    selContent = [selContent stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *insertHeader = [NSString stringWithFormat:@"#import \"%@.h\"", selContent];
    
    BOOL hasImportHeader = NO;
    int lastImportIndex = 0;
    for (int i = 0; i < buf.lines.count; i++) {
        NSString *line = buf.lines[i];
        NSRange range = [line rangeOfString:insertHeader];
        if (range.location != NSNotFound) {
            hasImportHeader = YES;
            NSString *explain = [line substringToIndex:range.location];
            if (explain.length > 2) {
                NSMutableString *replaceString = line.mutableCopy;
                if ([explain rangeOfString:@"#import"].location != NSNotFound) {
                    [replaceString insertString:@"\n" atIndex:range.location];
                } else  {
                    replaceString = [replaceString stringByReplacingOccurrencesOfString:explain withString:@""].mutableCopy;
                }
                [buf.lines replaceObjectAtIndex:i withObject:replaceString];
            }
            break;
        }
        if ([line rangeOfString:@"#import"].location != NSNotFound) {
            lastImportIndex = i+1;
        }
        if ([line rangeOfString:@"@implementation"].location != NSNotFound
            || ([line rangeOfString:@"@interface"].location != NSNotFound || [line rangeOfString:@"@NS_ASSUME_NONNULL_BEGIN"].location != NSNotFound)) {
            if (lastImportIndex != 0) {
                lastImportIndex = MIN(i, lastImportIndex);
            } else {
                lastImportIndex = i;
            }
            break;
        }
    }
    if (!hasImportHeader) {
        [buf.lines insertObject:insertHeader atIndex:lastImportIndex];
    }
}

@end
