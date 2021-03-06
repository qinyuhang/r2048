//
// Created by Viktor Belenyesi on 30/03/14.
// Copyright (c) 2014 Viktor Belenyesi. All rights reserved.
//

#import "RTTScoreView.h"
#import "UIColor+RTTFromHex.h"

@implementation RTTScoreView {
    UILabel* _scoreLabel;
}

- (instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor fromHex:0xbbada0];
        self.layer.cornerRadius = 3.0f;

        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 5.0f, self.bounds.size.width, kButtonHeight * 0.3f)];
        titleLabel.textColor = [UIColor fromHex:0xeee4da];
        titleLabel.font = [UIFont boldSystemFontOfSize:10.0f];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        titleLabel.text = title;
        [self addSubview:titleLabel];

        _scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 5.0f + kButtonHeight * 0.3f, self.bounds.size.width, kButtonHeight * 0.7f - 10.0f)];
        _scoreLabel.textColor = [UIColor whiteColor];
        _scoreLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        _scoreLabel.textAlignment = NSTextAlignmentCenter;
        _scoreLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        [self addSubview:_scoreLabel];

    }
    return self;
}

- (void)setScore:(int)score {
    int diff = score - _score;
    if (diff > 0 && self.animateChange) {
        UILabel *flyingLabel = [[UILabel alloc] initWithFrame:_scoreLabel.frame];
        flyingLabel.textColor = [UIColor fromHex:0x776e65];
        flyingLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        flyingLabel.textAlignment = NSTextAlignmentCenter;
        flyingLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        flyingLabel.text = [NSString stringWithFormat:@"+%d", diff];
        flyingLabel.alpha = 0.0f;
        [self addSubview:flyingLabel];

        [UIView animateKeyframesWithDuration:(kScaleAnimDuration + kSlideAnimDuration) * 4.0f
                                       delay:0.0f
                                     options:UIViewKeyframeAnimationOptionCalculationModeCubic
                                  animations:^{
            [UIView addKeyframeWithRelativeStartTime:0.0f relativeDuration:0.1f animations:^{
              flyingLabel.alpha = 1.0f;
            }];
            [UIView addKeyframeWithRelativeStartTime:0.1f relativeDuration:0.4f animations:^{
              flyingLabel.frame = CGRectOffset(flyingLabel.frame, 0.0f, -20.0f);
            }];
            [UIView addKeyframeWithRelativeStartTime:0.5f relativeDuration:0.5f animations:^{
              flyingLabel.frame = CGRectOffset(flyingLabel.frame, 0.0f, -40.0f);
              flyingLabel.alpha = 0.0f;
            }];
                                  } completion:^(BOOL finished) {
            [flyingLabel removeFromSuperview];
        }];
    }

    _score = score;
    _scoreLabel.text = [NSString stringWithFormat:@"%d", score];
}

@end
