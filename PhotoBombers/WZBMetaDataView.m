//
//  WZBMetaDataView.m
//  PhotoBombers
//
//  Created by wuzhengbin on 14-4-2.
//  Copyright (c) 2014年 wzb. All rights reserved.
//

#import "WZBMetaDataView.h"
#import "WZBPhotoController.h"
#import <SAMCache/SAMCache.h>
#import <SAMCategories/NSDate+SAMAdditions.h>

@interface WZBMetaDataView ()

@property (nonatomic) UIImageView *avatarImageView;
@property (nonatomic) UIButton *usernameButton;
@property (nonatomic) UIButton *timeButton;
@property (nonatomic) UIButton *likesButton;
@property (nonatomic) UIButton *commentsButton;

@end

@implementation WZBMetaDataView

- (void)setPhoto:(NSDictionary *)photo
{
    _photo = photo;
    
    NSDate *createdAt = [NSDate dateWithTimeIntervalSince1970:[_photo[@"created_time"] doubleValue]];
    [self.timeButton setTitle:[createdAt sam_briefTimeInWords] forState:UIControlStateNormal];
    
    // TODO: Set the avatar, username, time, number of likes, and number of comments
    [self.usernameButton setTitle:_photo[@"user"][@"username"] forState:UIControlStateNormal];
    
    [self.commentsButton setTitle:[NSString stringWithFormat:@"%d",[_photo[@"comments"][@"count"] intValue]] forState:UIControlStateNormal];
    [self.likesButton setTitle:[NSString stringWithFormat:@"%d",[_photo[@"likes"][@"count"] intValue]] forState:UIControlStateNormal];
 
    
    //头像
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [[NSURL alloc] initWithString:_photo[@"user"][@"profile_picture"]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        NSData *data = [[NSData alloc] initWithContentsOfURL:location];
        UIImage *image = [[UIImage alloc] initWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            _avatarImageView.image = image;
        });
    }];
    [task resume];
}

#pragma mark - Actions
- (void)openUser:(id)sender
{
    NSURL *url = [[NSURL alloc] initWithString:_photo[@"user"][@"website"]];
    [[UIApplication sharedApplication] openURL:url];
}

- (void)openPhoto:(id)sender
{
    NSURL *url = [[NSURL alloc] initWithString:_photo[@"link"]];
    [[UIApplication sharedApplication] openURL:url];
}

#pragma mark - UIView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self addSubview:self.usernameButton];
        [self addSubview:self.timeButton];
        [self addSubview:self.likesButton];
        [self addSubview:self.commentsButton];
        [self addSubview:self.avatarImageView];
    }
    
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size {
	return CGSizeMake(320.0f, 400.0f);
}

#pragma mark - UIControls
- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0f, 0.0f, 32.0f, 32.0f)];
        _avatarImageView.layer.cornerRadius = 16.0f;
        _avatarImageView.layer.borderColor = [[self class] darkTextColor].CGColor;
        _avatarImageView.layer.borderWidth = 1.0f;
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0f];
        _avatarImageView.userInteractionEnabled = NO;
    }
    return _avatarImageView;
}

- (UIButton *)usernameButton
{
    if (!_usernameButton) {
        _usernameButton = [[UIButton alloc] initWithFrame:CGRectMake(47.0f, 0.0f, 200.0f, 32.0f)];
        _usernameButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        _usernameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        UIColor *textColor = [[self class] darkTextColor];
        [_usernameButton setTitleColor:textColor forState:UIControlStateNormal];
        [_usernameButton setTitleColor:[textColor colorWithAlphaComponent:0.5f] forState:UIControlStateHighlighted];
        [_usernameButton addTarget:self action:@selector(openUser:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _usernameButton;
}

- (UIButton *)likesButton {
	if (!_likesButton) {
		_likesButton = [[UIButton alloc] initWithFrame:CGRectMake(10.0f, 360.0f, 50.0f, 40.0f)];
		_likesButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
		[_likesButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
		_likesButton.adjustsImageWhenHighlighted = NO;
		_likesButton.imageEdgeInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 6.0f);
        
		UIColor *textColor = [[self class] lightTextColor];
		[_likesButton setTitleColor:textColor forState:UIControlStateNormal];
		[_likesButton setTitleColor:[textColor colorWithAlphaComponent:0.5f] forState:UIControlStateHighlighted];
		[_likesButton addTarget:self action:@selector(openPhoto:) forControlEvents:UIControlEventTouchUpInside];
	}
	return _likesButton;
}


- (UIButton *)commentsButton {
	if (!_commentsButton) {
		_commentsButton = [[UIButton alloc] initWithFrame:CGRectMake(260.0f, 360.0f, 50.0f, 40.0f)];
		_commentsButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
		[_commentsButton setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
		_commentsButton.adjustsImageWhenHighlighted = NO;
		_commentsButton.imageEdgeInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 6.0f);
		_commentsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        
		UIColor *textColor = [[self class] lightTextColor];
		[_commentsButton setTitleColor:textColor forState:UIControlStateNormal];
		[_commentsButton setTitleColor:[textColor colorWithAlphaComponent:0.5f] forState:UIControlStateHighlighted];
		[_commentsButton addTarget:self action:@selector(openPhoto:) forControlEvents:UIControlEventTouchUpInside];
	}
	return _commentsButton;
}

- (UIButton *)timeButton {
	if (!_timeButton) {
		_timeButton = [[UIButton alloc] initWithFrame:CGRectMake(260.0f, 0.0f, 50.0f, 32.0f)];
		_timeButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
		[_timeButton setImage:[UIImage imageNamed:@"time"] forState:UIControlStateNormal];
		_timeButton.adjustsImageWhenHighlighted = NO;
		_timeButton.imageEdgeInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 6.0f);
		_timeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        
		UIColor *textColor = [[self class] lightTextColor];
		[_timeButton setTitleColor:textColor forState:UIControlStateNormal];
		[_timeButton setTitleColor:[textColor colorWithAlphaComponent:0.5f] forState:UIControlStateHighlighted];
		[_timeButton addTarget:self action:@selector(openPhoto:) forControlEvents:UIControlEventTouchUpInside];
	}
	return _timeButton;
}

#pragma mark - Private

+ (UIColor *)darkTextColor {
	return [UIColor colorWithRed:0.949f green:0.510f blue:0.380f alpha:1.0f];
}


+ (UIColor *)lightTextColor {
	return [UIColor colorWithRed:0.973f green:0.753f blue:0.686f alpha:1.0f];
}


@end
