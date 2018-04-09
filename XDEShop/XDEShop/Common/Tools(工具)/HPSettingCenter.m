//
//  HPSettingCenter.m
//  ZHDJ
//
//  Created by 秦正华 on 2017/10/26.
//  Copyright © 2017年 Hopex. All rights reserved.
//

#import "HPSettingCenter.h"

@implementation HPSettingCenter

+(BOOL)notificationIsOpen
{
    UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
    if (UIUserNotificationTypeNone == setting.types) {
        DEBUGLog(@"推送关闭");
        return false;
    }else{
        DEBUGLog(@"推送打开");
        return true;
    }
}

+(void)toNoticatonSetCenter
{
    if (UIApplicationOpenSettingsURLString != NULL) {
        UIApplication *application = [UIApplication sharedApplication];
        NSURL *URL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
            [application openURL:URL options:@{} completionHandler:nil];
        } else {
            [application openURL:URL];
        }
    }
    
}

+(void)getCacheSizeCompletion:(void(^__nullable)(CGFloat cacheSize))completion
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSUInteger imageCacheSize = [[SDImageCache sharedImageCache] getSize];
        //获取自定义缓存大小
        //用枚举器遍历 一个文件夹的内容
        //1.获取 文件夹枚举器
        NSString *myCachePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
        NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath:myCachePath];
        __block NSUInteger count = 0;
        //2.遍历
        for (NSString *fileName in enumerator) {
            NSString *path = [myCachePath stringByAppendingPathComponent:fileName];
            NSDictionary *fileDict = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
            count += fileDict.fileSize;//自定义所有缓存大小
        }
        // 得到是字节  转化为M
        CGFloat totalSize = ((CGFloat)imageCacheSize+count)/1024/1024;
        
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(totalSize);
            });
        }
    });
    
    
    
}

+(void)clearCacheSizeCompletion:(void(^__nullable)(void))completion
{
    //删除两部分
    //2.删除自己缓存
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *myCachePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
        //返回路径中的文件数组
        NSArray*files = [[NSFileManager defaultManager]subpathsAtPath:myCachePath];
        DEBUGLog(@"文件数：%ld",[files count]);
        for(NSString *p in files){
            NSError*error;
            NSString*path = [myCachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",p]];
            if([[NSFileManager defaultManager]fileExistsAtPath:path])
            {
                BOOL isRemove = [[NSFileManager defaultManager]removeItemAtPath:path error:&error];
                if(isRemove) {
                    DEBUGLog(@"清除成功");
                }else{
                    DEBUGLog(@"清除失败--%@",error);
                }
            }
        }
        
        //1.删除 sd 图片缓存
        //先清除内存中的图片缓存
        [[SDImageCache sharedImageCache] clearMemory];
        //清除磁盘的缓存
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:completion];
    });
}

+(NSString *)getVerisonNum
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+(NSString *)getBuildNum
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

+(NSString *)getBuilderID
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
}

+(CFAbsoluteTime)startTime
{
    CFAbsoluteTime start =CFAbsoluteTimeGetCurrent();
    return start;
}

+(CFAbsoluteTime)expendTime:(CFAbsoluteTime)startTime
{
    CFAbsoluteTime expend = (CFAbsoluteTimeGetCurrent() - startTime);
    return expend;
}


@end
