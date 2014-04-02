//
//  WZBPhotoController.m
//  PhotoBombers
//
//  Created by wuzhengbin on 14-3-30.
//  Copyright (c) 2014年 wzb. All rights reserved.
//

#import "WZBPhotoController.h"
#import <SAMCache/SAMCache.h>

@implementation WZBPhotoController

+ (void)imageForPhoto:(NSDictionary *)photo size:(NSString *)size completion:(void(^)(UIImage *image))completion
{
    NSString *key = [[NSString alloc] initWithFormat:@"%@-thumbnail", photo[@"id"]];
    UIImage *image = [[SAMCache sharedCache] objectForKey:key];
    if (image) {
        completion(image);
        return;
    }
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [[NSURL alloc] initWithString:photo[@"images"][size][@"url"]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        NSData *data = [[NSData alloc] initWithContentsOfURL:location];
        UIImage *image = [[UIImage alloc] initWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
        
        });
    }];
    [task resume];
}

@end
