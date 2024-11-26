#import <Foundation/Foundation.h>
@interface ContextInput : NSObject
- (void)Context:(int)worker obj:(int)obj;
- (int)Syntax;
- (void)Extensions:(int)previous;
@end