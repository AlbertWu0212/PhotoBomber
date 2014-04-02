//
//  WZBPhotoController.h
//  PhotoBombers
//
//  Created by wuzhengbin on 14-3-30.
//  Copyright (c) 2014年 wzb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZBPhotoController : NSObject

+ (void)imageForPhoto:(NSDictionary *)photo size:(NSString *)size completion:(void(^)(UIImage *image))completion;

@end
