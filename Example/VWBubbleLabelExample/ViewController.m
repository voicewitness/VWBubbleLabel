//
//  ViewController.m
//  VWBubbleLabelExample
//
//  Created by voicewitness on 16/8/17.
//  Copyright © 2016年 voicewitness. All rights reserved.
//

#import "ViewController.h"
#import "VWBubbleLabel.h"

@interface ViewController () {
    VWBubbleLabel *_leftAlignLabel;
    VWBubbleLabel *_rightAlignLabel;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initLeftAlignLabel];
    [self initRightAlignLabel];
    
    [self testFlexibleTextMode];
    //    [self testFixedWidthTextMode];
    [self testNormalText];
    //    [self testAttributedText];
    
}

- (void)initLeftAlignLabel {
    _leftAlignLabel = [[VWBubbleLabel alloc]initWithFrame:CGRectMake(0, 100, 0, 0)];
    [self.view addSubview:_leftAlignLabel];
    _leftAlignLabel.font = [UIFont systemFontOfSize:11];
    _leftAlignLabel.numberOfLines = 0;
    _leftAlignLabel.textColor = [UIColor blackColor];
    _leftAlignLabel.textInset = UIEdgeInsetsMake(4, 10, 11, 10);
    _leftAlignLabel.bubble = [UIImage imageNamed:@"bubble"];
    _leftAlignLabel.bubbleInset = UIEdgeInsetsMake(12, 30, 39, 10);
    _leftAlignLabel.maxWidth = 140;
    _leftAlignLabel.maxHeight = 100;
}

- (void)initRightAlignLabel {
    _rightAlignLabel = [[VWBubbleLabel alloc]initWithFrame:CGRectMake(300, 100, 0, 0)];
    [self.view addSubview:_rightAlignLabel];
    _rightAlignLabel.font = [UIFont systemFontOfSize:11];
    _rightAlignLabel.numberOfLines = 0;
    _rightAlignLabel.textColor = [UIColor blackColor];
    _rightAlignLabel.textInset = UIEdgeInsetsMake(14, 10, 11, 10);
    _rightAlignLabel.bubble = [UIImage imageNamed:@"bubble"];
    _rightAlignLabel.bubbleInset = UIEdgeInsetsMake(12, 30, 39, 10);
    _rightAlignLabel.maxWidth = 140;
    _rightAlignLabel.maxHeight = 100;
    _rightAlignLabel.labelAlignment = VWBubbleLabelAlignmentRight;
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
    _leftAlignLabel.textMode = VWBubbleLabelTextModeFixedWidth;
}

/**
 *  测试高度固定的气泡背景
 *  test bubble fixed height
 */
- (void)testFixedHeightTextMode
{
    _leftAlignLabel.textMode = VWBubbleLabelTextModeFixedHeight;
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
    _leftAlignLabel.text = [NSString stringWithFormat:@"%@例",_leftAlignLabel.text?:@"例"];
    _rightAlignLabel.text = [NSString stringWithFormat:@"%@例",_rightAlignLabel.text?:@"例"];
}

- (void)addAttributedText
{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]init];
    if (_leftAlignLabel.attributedText)
    {
        [text appendAttributedString:_leftAlignLabel.attributedText];
    }
    NSLog(@"%f",rand()%100/100.0f);
    [text appendAttributedString:[[NSAttributedString alloc]initWithString:@"例" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:rand()%100*0.01 green:rand()%100*0.01 blue:rand()%100*0.01 alpha:1],NSFontAttributeName:[UIFont systemFontOfSize:rand()%5+10]}]];
    _leftAlignLabel.attributedText = text;
}

@end
