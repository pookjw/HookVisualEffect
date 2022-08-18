//
//  UIVisualEffectView+Intensity.m
//  HookVisualEffect
//
//  Created by pookjw on 8/17/22.
//

#import "UIVisualEffectView+Intensity.h"
#import <objc/message.h>

@interface UIVisualEffectView (Intensity)
@property (readonly) id backgroundHost; // _UIVisualEffectHost
@property (readonly) __kindof UIView *backdropView; // _UIVisualEffectBackdropView
@end

@implementation UIVisualEffectView (Intensity)

- (id)backgroundHost {
    id backgroundHost = ((id (*)(id, SEL))objc_msgSend)(self, NSSelectorFromString(@"_backgroundHost")); // _UIVisualEffectHost
    return backgroundHost;
}

- (__kindof UIView * _Nullable)backdropView {
    __kindof UIView *backdropView = ((__kindof UIView * (*)(id, SEL))objc_msgSend)(self.backgroundHost, NSSelectorFromString(@"contentView")); // _UIVisualEffectBackdropView
    return backdropView;
}

- (CGFloat)intensity {
    __kindof UIView *backdropView = self.backdropView; // _UIVisualEffectBackdropView
    __kindof CALayer *backdropLayer = ((__kindof CALayer * (*)(id, SEL))objc_msgSend)(backdropView, NSSelectorFromString(@"backdropLayer")); // UICABackdropLayer

    NSArray *filters = backdropLayer.filters;
    id _Nullable __block gaussianBlur = nil; // CAFilter

    [filters enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj respondsToSelector:NSSelectorFromString(@"type")]) return;

        NSString *type = ((NSString * (*)(id, SEL))objc_msgSend)(obj, NSSelectorFromString(@"type"));

        if (![type isKindOfClass:[NSString class]]) return;

        if ([type isEqualToString:@"gaussianBlur"]) {
            gaussianBlur = obj;
            *stop = YES;
        }
    }];

    if (gaussianBlur == nil) return 0.0f;

    NSNumber * _Nullable inputRadius = [gaussianBlur valueForKeyPath:@"inputRadius"];

    if ((inputRadius == nil) || (![inputRadius isKindOfClass:[NSNumber class]])) return 0.0f;

    return [inputRadius floatValue];
}

- (void)setIntensity:(CGFloat)intensity {
    id descriptor = ((id (*)(id, SEL, id, BOOL))objc_msgSend)(self, NSSelectorFromString(@"_effectDescriptorForEffects:usage:"), @[self.effect], YES); // _UIVisualEffectDescriptor

    NSArray *filterEntries = ((NSArray * (*)(id, SEL))objc_msgSend)(descriptor, NSSelectorFromString(@"filterEntries")); // NSArray<_UIVisualEffectFilterEntry *>

    id _Nullable __block gaussianBlur = nil; // _UIVisualEffectFilterEntry

    [filterEntries enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *filterType = ((NSString * (*)(id, SEL))objc_msgSend)(obj, NSSelectorFromString(@"filterType"));

        if ([filterType isEqualToString:@"gaussianBlur"]) {
            gaussianBlur = obj;
            *stop = YES;
        }
    }];

    if (gaussianBlur == nil) return;

    NSMutableDictionary *requestedValues = [((NSDictionary * (*)(id, SEL))objc_msgSend)(gaussianBlur, NSSelectorFromString(@"requestedValues")) mutableCopy];

    if (![requestedValues.allKeys containsObject:@"inputRadius"]) {
        NSLog(@"Not supported effect.");
        return;
    }

    requestedValues[@"inputRadius"] = [NSNumber numberWithFloat:intensity];

    ((void (*)(id, SEL, NSDictionary *))objc_msgSend)(gaussianBlur, NSSelectorFromString(@"setRequestedValues:"), requestedValues);

    ((void (*)(id, SEL, id))objc_msgSend)(self.backgroundHost, NSSelectorFromString(@"setCurrentEffectDescriptor:"), descriptor);

    ((void (*)(id, SEL))objc_msgSend)(self.backdropView, NSSelectorFromString(@"applyRequestedFilterEffects"));
}

@end
