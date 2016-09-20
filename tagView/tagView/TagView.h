//
//  TagView.h
//  tagView
//
//  Created by Davis on 16/9/20.
//  Copyright © 2016年 Davis. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
// 标签高度
UIKIT_EXTERN const CGFloat TagHeight;
// 标签上下的间距
UIKIT_EXTERN const CGFloat Margin;

NS_ASSUME_NONNULL_BEGIN

@protocol TagViewDelegate <NSObject>

- (void)tagViewClickTagIndex:(NSInteger)index;

@end

typedef void(^TagViewClick)(NSInteger index);

@interface TagView : UIView
/** 标签数据数组 */
@property (nonatomic, strong) NSArray<NSString *> *tags;

@property (nonatomic, weak) id<TagViewDelegate> delegate;

/** 点击回调 */
@property (nonatomic, copy) TagViewClick clickHandel;
/**
 *  获取排版后的标签的高度
 *
 *  @param width 指定的宽度
 *  @param tags  标签标题数组
 */
+ (CGFloat)heightForWidth:(CGFloat)width tags:(NSArray<NSString *> *)tags;

@end

NS_ASSUME_NONNULL_END