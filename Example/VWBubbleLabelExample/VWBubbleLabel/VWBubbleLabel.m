//
//  VWBubbleLabel.m
//  BubbleEx
//
//  Created by voicewitness on 16/8/17.
//  Copyright © 2016年 voicewitness. All rights reserved.
//

#import "VWBubbleLabel.h"

@interface VWBubbleLabel()

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) UIImageView *bubbleImageView;

@property (nonatomic, weak) NSLayoutConstraint *textTopConstraint;
@property (nonatomic, weak) NSLayoutConstraint *textBottomConstraint;
@property (nonatomic, weak) NSLayoutConstraint *textLeadingConstraint;
@property (nonatomic, weak) NSLayoutConstraint *textTrailingConstraint;
@property (nonatomic, weak) NSLayoutConstraint *textHeightConstraint;
@property (nonatomic, weak) NSLayoutConstraint *textWidthConstraint;
@property (nonatomic, strong) NSLayoutConstraint *labelAlignLeftConstraint;
@property (nonatomic, strong) NSLayoutConstraint *labelAlignRightConstraint;

@property (nonatomic, assign) CGSize textSize;

@end

@implementation VWBubbleLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self)
    {
        return nil;
    }
    [self commonInit];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (!self)
    {
        return nil;
    }
    [self commonInit];
    return self;
}

- (void)commonInit
{
    [self initBasic];
    [self initUI];
}

- (void)initBasic
{
    CGRect screenBounds = [[UIScreen mainScreen]bounds];
    self.maxWidth = screenBounds.size.width;
    self.maxHeight = screenBounds.size.height;
    self.textLeadingConstraint = [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.bubbleImageView attribute:NSLayoutAttributeLeading multiplier:1 constant:self.textInset.left];
    self.textTrailingConstraint = [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.bubbleImageView attribute:NSLayoutAttributeTrailing multiplier:1 constant:-self.textInset.right];
    self.textTopConstraint = [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.bubbleImageView attribute:NSLayoutAttributeTop multiplier:1 constant:self.textInset.top];
    self.textBottomConstraint = [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bubbleImageView attribute:NSLayoutAttributeBottom multiplier:1 constant:-self.textInset.bottom];
    self.textWidthConstraint = [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:0];
    self.textHeightConstraint = [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:0];
    self.labelAlignLeftConstraint = [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    self.labelAlignRightConstraint = [NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
}

- (void)initUI
{
    [self.subviews makeObjectsPerformSelector:@selector(removeObject:)];
    [self addSubview:self.bubbleImageView];
    [self addSubview:self.textLabel];
    self.bubbleImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:self.labelAlignLeftConstraint];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.bubbleImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self addConstraint:self.textTopConstraint];
    [self addConstraint:self.textBottomConstraint];
    [self addConstraint:self.textLeadingConstraint];
    [self addConstraint:self.textTrailingConstraint];
    [self.textLabel addConstraint:self.textWidthConstraint];
    [self.textLabel addConstraint:self.textHeightConstraint];
}

- (void)updateConstraints
{
    self.textLeadingConstraint.constant = self.textInset.left;
    self.textTrailingConstraint.constant = -self.textInset.right;
    self.textTopConstraint.constant = self.textInset.top;
    self.textBottomConstraint.constant = -self.textInset.bottom;
    self.textWidthConstraint.constant = (self.textMode == VWBubbleLabelTextModeFixedWidth||self.textMode == VWBubbleLabelTextModeFixedSize)?self.maxWidth:self.textSize.width;
    self.textHeightConstraint.constant = (self.textMode == VWBubbleLabelTextModeFixedHeight||self.textMode == VWBubbleLabelTextModeFixedSize)?self.maxHeight:self.textSize.height;
    if (self.labelAlignment == VWBubbleLabelAlignmentLeft) {
        [self removeConstraint:self.labelAlignRightConstraint];
        [self addConstraint:self.labelAlignLeftConstraint];
    } else {
        [self removeConstraint:self.labelAlignLeftConstraint];
        [self addConstraint:self.labelAlignRightConstraint];
    }
    [super updateConstraints];
    
}

- (void)setBubble:(UIImage *)bubble withInset:(UIEdgeInsets)inset
{
    [self setBubble:bubble withInset:inset resizingMode:UIImageResizingModeTile];
}

- (void)setBubble:(UIImage *)bubble withInset:(UIEdgeInsets)inset resizingMode:(UIImageResizingMode)resizingMode
{
    _bubble = bubble;
    _bubbleInset = inset;
    _bubbleResizingMode = resizingMode;
    [self setUpBubble];
}

+ (CGSize)calText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize options:(NSStringDrawingOptions)options
{
    CGSize size = [text boundingRectWithSize:maxSize options:options attributes:@{NSFontAttributeName:font} context:nil].size;
    size.width = ceil(size.width);
    size.height = ceil(size.height);
    return size;
}

- (void)updateTextSize
{
    if (self.attributedText)
    {
        self.textSize = [self.textLabel sizeThatFits:CGSizeMake(self.maxWidth, self.maxHeight)];
        self.textSize = CGSizeMake(ceil(self.textSize.width), ceil(self.textSize.height));
    }
    else
    {
        self.textSize = [[self class]calText:self.text font:self.textLabel.font maxSize:CGSizeMake(self.maxWidth, self.maxHeight) options:self.drawingOptions?self.drawingOptions:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)];
    }
}

- (void)setUpBubble
{
    self.bubble = [self.bubble resizableImageWithCapInsets:self.bubbleInset resizingMode:UIImageResizingModeStretch];
    self.bubbleImageView.image = _bubble;
}

- (BOOL)isTextInitialied
{
    if (self.text || self.attributedText)
    {
        return YES;
    }
    return NO;
}

- (void)setText:(NSString *)text
{
    _text = text;
    self.textLabel.text = text;
    [self updateTextSize];
    [self setNeedsUpdateConstraints];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    _attributedText = attributedText;
    self.textLabel.attributedText = attributedText;
    [self updateTextSize];
    [self setNeedsUpdateConstraints];
}

- (void)setTextMode:(VWBubbleLabelTextMode)textMode
{
    _textMode = textMode;
    [self setNeedsUpdateConstraints];
}

- (void)setLabelAlignment:(VWBubbleLabelAlignment)labelAlignment {
    _labelAlignment = labelAlignment;
    [self setNeedsUpdateConstraints];
}

- (void)setMaxWidth:(CGFloat)maxWidth
{
    _maxWidth = maxWidth;
    [self updateTextSize];
    ![self isTextInitialied]?:[self setNeedsUpdateConstraints];
}

- (void)setMaxHeight:(CGFloat)maxHeight
{
    _maxHeight = maxHeight;
    [self updateTextSize];
    ![self isTextInitialied]?:[self setNeedsUpdateConstraints];
}

- (void)setBubbleInset:(UIEdgeInsets)bubbleInset
{
    _bubbleInset = bubbleInset;
    !self.bubble?:[self setUpBubble];
}

- (void)setBubbleResizingMode:(UIImageResizingMode)bubbleResizingMode
{
    _bubbleResizingMode = bubbleResizingMode;
    !self.bubble?:[self setUpBubble];
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    self.textLabel.textColor = textColor;
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    self.textLabel.font = font;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    _textAlignment = textAlignment;
    self.textLabel.textAlignment = textAlignment;
}

- (void)setNumberOfLines:(NSUInteger)numberOfLines
{
    _numberOfLines = numberOfLines;
    self.textLabel.numberOfLines = numberOfLines;
}

- (UILabel *)textLabel
{
    if (!_textLabel)
    {
        _textLabel = [[UILabel alloc]init];
    }
    return _textLabel;
}

- (UIImageView *)bubbleImageView
{
    if (!_bubbleImageView)
    {
        _bubbleImageView = [[UIImageView alloc]init];
    }
    return _bubbleImageView;
}

@end
