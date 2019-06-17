//
//  Sqlite3Manager.h
//  ExperimentWeek
//
//  Created by Bule on 2019/6/11.
//  Copyright © 2019 Bule. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

NS_ASSUME_NONNULL_BEGIN

@interface Sqlite3Manager : NSObject

@property(nonatomic,strong)FMDatabase * database;

- (void) showById: (NSInteger)index;

- (NSMutableArray*) getAll;
- (NSMutableArray*) getByName: (NSString *)name;

- (BOOL) addWithName: (NSString*) name Number: (NSString*)number Sex: (NSString*)sex;

- (BOOL) deleteById: (NSInteger)index;
- (BOOL) deleteAll;

- (BOOL) updateWithId: (NSInteger)index Name: (NSString*)name Number: (NSString*)number Sex: (NSString*)sex;

- (void) test;


@end

NS_ASSUME_NONNULL_END
