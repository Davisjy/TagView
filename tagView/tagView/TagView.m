//
//  TagView.m
//  tagView
//
//  Created by Davis on 16/9/20.
//  Copyright © 2016年 Davis. All rights reserved.
//

#import "TagView.h"
#import "UIView+Awesome.h"

#define Font(fontSize) [UIFont fontWithName:@"ArialMT" size:fontSize]

@interface TagView ()<TagViewDelegate>
/** 按钮数组 */
@property (nonatomic, strong) NSMutableArray<UIButton *> *tagButtons;
@end

const CGFloat TagHeight = 30;
const CGFloat Margin = 15;

@implementation TagView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _tagButtons = @[].mutableCopy;
        UILabel *label = [UILabel labelWithFont:12 text:@"看我看我" textColor:[UIColor redColor] textAlignment:NSTextAlignmentLeft numberOfLines:0];
        label.frame = CGRectMake(0, 0, 300, 12);
        [self addSubview:label];
    }
    return self;
}

- (void)setTags:(NSArray<NSString *> *)tags {
    NSInteger tagsCount = [tags count];
    
    for (NSInteger i=[_tagButtons count]; i<tagsCount; i++) {
        UIButton *button = [UIButton buttonWhiteTitleWith:tags[i] color:[UIColor cyanColor] andFontSize:12];
        button.backgroundColor = [UIColor whiteColor];
        button.layer.cornerRadius = 12;
        button.layer.masksToBounds = YES;
        button.layer.borderWidth = 0.5;
        button.layer.borderColor = [UIColor redColor].CGColor;
        [button addTarget:self action:@selector(onClickTag:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [_tagButtons addObject:button];
    }
    
    NSInteger count = [_tagButtons count];
    for (NSInteger i=count-1; i>=tagsCount; i--) {
        [_tagButtons[i] removeFromSuperview];
        [_tagButtons removeLastObject];
    }
    
    CGRect rect = CGRectMake(0, Margin * 2, 0, TagHeight);
    
    for (NSInteger i = 0; i < tagsCount; i++) {
        _tagButtons[i].tag = i;
        
        CGFloat width = [tags[i] boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, TagHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: Font(12)} context:NULL].size.width;
        
        if (rect.origin.x + rect.size.width + 10 + width + TagHeight > self.width) {
            rect.origin.x = 10;
            rect.origin.y += rect.size.height+10;
        }
        else {
            rect.origin.x += rect.size.width + 10;
        }
        rect.size.width = width + TagHeight;
        
        _tagButtons[i].frame = rect;
    }
}

- (void)onClickTag:(UIButton *)sender {

    if ([self.delegate respondsToSelector:@selector(tagViewClickTagIndex:)]) {
        [self.delegate tagViewClickTagIndex:sender.tag];
    }
    
    !_clickHandel ?:_clickHandel(sender.tag);
}

+ (CGFloat)heightForWidth:(CGFloat)width tags:(NSArray<NSString *> *)tags {
    if ([tags count] == 0) {
        return 0;
    }
    width = width == 0 ? kScreenWidth : width;
    
    CGRect rect = CGRectMake(0, Margin * 2, 0, TagHeight);
    for (NSInteger i=0; i<tags.count; i++) {
        
        CGFloat textWidth = [tags[i] boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, TagHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: Font(12)} context:NULL].size.width;
        
        if (rect.origin.x + rect.size.width + 10 + textWidth + TagHeight > width) {
            rect.origin.x = 10;
            rect.origin.y += rect.size.height+10;
        }
        else {
            rect.origin.x += rect.size.width + 10;
        }
        rect.size.width = textWidth + TagHeight;
    }
    
    return rect.origin.y + rect.size.height + Margin;
}


@end
