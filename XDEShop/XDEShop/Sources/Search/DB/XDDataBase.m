//
//  XDDataBase.m
//  XDEShop
//
//  Created by Celia on 2018/4/8.
//  Copyright © 2018年 Hopex. All rights reserved.
//

#import "XDDataBase.h"

static NSInteger recordCount = 10;  //搜索记录 记录的数量

@interface XDDataBase ()
@property (nonatomic, strong) FMDatabaseQueue *dbQueue;
@end

@implementation XDDataBase

HPSingleton_implementation(XDDataBase)

- (void)openSearchRecordDataBase {
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *searchDBPath = [path stringByAppendingPathComponent:@"searchRecord.sqlite"];
    DEBUGLog(@"path == %@",searchDBPath);
    self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:searchDBPath];
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        
        BOOL result = [db executeUpdate:@"create table if not exists search_record (s_id integer primary key autoincrement,keyword text);"];
        if (result) {
            NSLog(@"创建表成功");
        }else {
            NSLog(@"创建表失败");
        }
        
    }];
}

- (void)addSearchRecordText:(NSString *)text {
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        FMResultSet *result = [db executeQuery:@"select * from search_record where keyword = ?;",text];
        NSInteger keyCount = 0;
        while (result.next) {
            keyCount++;
        }
        // 跳过重复字段
        if (keyCount == 0) {
            [db executeUpdate:@"insert into search_record (keyword) values (?);",text];
        }
        
    }];
}

- (void)deleteAllSearchRecord {
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        [db executeUpdate:@"delete from search_record;"];
    }];
}

- (void)querySearchRecord:(void(^)(NSArray *resultArray))resutlBlock {
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        FMResultSet *result = [db executeQuery:@"select * from search_record;"];
        NSMutableArray *array = [NSMutableArray array];
        while ([result next]) {
            NSString *keyword = [result stringForColumn:@"keyword"];
            NSLog(@"db key %@",keyword);
            if (keyword.length) {
                [array insertObject:keyword atIndex:0];
            }
        }
        NSMutableArray *tempArray = [array mutableCopy];
        // 删除数据库多余的数据
        if (array.count > recordCount) {
            for (int i = (int)recordCount; i < array.count; i++) {
                NSString *keyword = array[i];
                [tempArray removeObject:keyword];
                [db executeUpdate:@"delete from search_record where keyword = ?;",keyword];
            }
        }
        resutlBlock(tempArray);
    }];
}

@end
