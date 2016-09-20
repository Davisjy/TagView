//
//  ViewController.m
//  tagView
//
//  Created by Davis on 16/9/20.
//  Copyright © 2016年 Davis. All rights reserved.
//

#import "ViewController.h"
#import "TagView.h"

@interface ViewController ()<TagViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *datas = @[@"dfasjlfdj", @"fdj", @"fdsjdfl", @"fd", @"fdsjlfsjflsdf", @"dfasjlfdj", @"fdj", @"fdsjdfl",];
    
    CGFloat height = [TagView heightForWidth:0 tags:datas];
    TagView *tagView = [[TagView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, height)];
    tagView.delegate = self;
    
    tagView.backgroundColor = [UIColor yellowColor];
    tagView.tags = datas;
    
//    tagView.clickHandel = ^(NSInteger index) {
//        NSLog(@"%ld", (long)index);
//    };
    [self.view addSubview:tagView];
    
    NSLog(@"%f", height);
}

- (void)tagViewClickTagIndex:(NSInteger)index {
    NSLog(@"%ld", (long)index);
}

@end
