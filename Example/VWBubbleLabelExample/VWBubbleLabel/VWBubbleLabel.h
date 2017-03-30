//
//  VWBubbleLabel.h
//  version:1.0
//
//  Created by voicewitness on 16/8/17.
//  Copyright © 2016年 voicewitness. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, VWBubbleLabelTextMode)
{
    VWBubbleLabelTextModeFlexible,
    VWBubbleLabelTextModeFixedWidth,
    VWBubbleLabelTextModeFixedHeight,
    VWBubbleLabelTextModeFixedSize,
};

typedef NS_ENUM(NSInteger, VWBubbleLabelAlignment) {
    VWBubbleLabelAlignmentLeft,
    VWBubbleLabelAlignmentRight
};

@interface VWBubbleLabel : UIView

/**
 *  气泡图
 *  bubble image
 */
@property (nonatomic, strong) UIImage *bubble;

/**
 *  气泡图的盖边距
 *  cap inset for bubble
 */
@property (nonatomic) UIEdgeInsets bubbleInset;

/**
 *  气泡拉伸后填充方式
 *  resizing mode for bubble
 */
@property (nonatomic) UIImageResizingMode bubbleResizingMode;

/**
 *  文本的伸展方式
 *  alignment for label expanding
 */
@property (nonatomic) VWBubbleLabelAlignment labelAlignment;

/**
 *  普通文本
 *  plain text
 */
@property (nullable, nonatomic, copy) NSString *text;

/**
 *  富文本
 *  attributed text
 */
@property (nullable, nonatomic, copy) NSAttributedString *attributedText;

/**
 *  气泡模式
 *  mode for bubble
 *  default VWBubbleLabelTextModeFlexible
 */
@property (nonatomic) VWBubbleLabelTextMode textMode;

/**
 *  计算文本宽高时的选项
 *  option for drawing text
 */
@property (nonatomic) NSStringDrawingOptions drawingOptions;

/**
 *  文本到气泡的内边距
 *  inset for text in bubble
 */
@property (nonatomic) UIEdgeInsets textInset;

/**
 *  文本最大宽度，设置宽度固定模式时，最大宽度等于固定的宽度
 *  max width of text. Max width equals to fixed width only if set text mode width fixed(or size fixed)
 */
@property (nonatomic) CGFloat maxWidth;

/**
 *  文本最大高度，设置高度固定模式时，最大高度等于固定的高度
 *  max height of text. Max height equals to fixed height only if set text mode height fixed(or size fixed)
 */
@property (nonatomic) CGFloat maxHeight;

/**
 *  文本字体
 *  text font
 */
@property (nullable, nonatomic, strong) UIFont *font;

/**
 *  文本颜色
 *  text color
 */
@property (nullable, nonatomic, strong) UIColor *textColor;

/**
 *  文本对齐方式
 */
@property (nonatomic) NSTextAlignment textAlignment;

@property (nonatomic) NSUInteger numberOfLines;


- (void)setBubble:(UIImage *)bubble withInset:(UIEdgeInsets)inset;

- (void)setBubble:(UIImage *)bubble withInset:(UIEdgeInsets)inset resizingMode:(UIImageResizingMode)resizingMode;

@end

NS_ASSUME_NONNULL_END
