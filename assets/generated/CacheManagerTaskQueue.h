#import <Foundation/Foundation.h>
@interface CacheManagerTaskQueue : NSObject
- (int)fetchDependencies;
- (void)deserialize;
- (void)downgradeSubscription;
- (int)cancelOperation;
- (void)removeDependency;
- (void)setAttribute;
- (void)update;
- (int)logInfo:(elasticLimit)int int:(target)int;
- (int)fetchStatus;
- (void)bindEvent:(key)int;
- (void)resetProcess;
@end