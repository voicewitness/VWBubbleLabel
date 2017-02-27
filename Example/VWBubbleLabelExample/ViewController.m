//
//  ViewController.m
//  VWBubbleLabelExample
//
//  Created by voicewitness on 16/8/17.
//  Copyright © 2016年 voicewitness. All rights reserved.
//

#import "ViewController.h"
#import "VWBubbleLabel.h"

@interface ViewController ()
{
    VWBubbleLabel *label;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    label = [[VWBubbleLabel alloc]initWithFrame:CGRectMake(0, 100, 0, 0)];
    [self.view addSubview:label];
    label.font = [UIFont systemFontOfSize:11];
    label.numberOfLines = 0;
    label.textColor = [UIColor blackColor];
    label.textInset = UIEdgeInsetsMake(4, 10, 11, 10);
    label.bubble = [UIImage imageNamed:@"bubble"];
    label.bubbleInset = UIEdgeInsetsMake(12, 30, 39, 10);
    label.maxWidth = 140;
    label.maxHeight = 100;
    [self testFlexibleTextMode];
    //    [self testFixedWidthTextMode];
    [self testNormalText];
    //    [self testAttributedText];
}

/**
 *  测试自由变换大小的气泡背景
 *  test flexible bubble
 */
- (void)testFlexibleTextMode
{
    
}

/**
 *  测试宽度固定的气泡背景
 *  test bubble fixed width
 */
- (void)testFixedWidthTextMode
{
    label.textMode = VWBubbleLabelTextModeFixedWidth;
}

/**
 *  测试高度固定的气泡背景
 *  test bubble fixed height
 */
- (void)testFixedHeightTextMode
{
    label.textMode = VWBubbleLabelTextModeFixedHeight;
}

/**
 *  测试普通文本
 *  test plain text
 */
- (void)testNormalText
{
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(addText) userInfo:nil repeats:YES];
}

/**
 *  测试富文本
 *  test attributedText
 */
- (void)testAttributedText
{
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(addAttributedText) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addText
{
    label.text = [NSString stringWithFormat:@"%@例",label.text?label.text:@"例"];
}

- (void)addAttributedText
{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]init];
    if (label.attributedText)
    {
        [text appendAttributedString:label.attributedText];
    }
    NSLog(@"%f",rand()%100/100.0f);
    [text appendAttributedString:[[NSAttributedString alloc]initWithString:@"例" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:rand()%100*0.01 green:rand()%100*0.01 blue:rand()%100*0.01 alpha:1],NSFontAttributeName:[UIFont systemFontOfSize:rand()%5+10]}]];
    label.attributedText = text;
}

@end
