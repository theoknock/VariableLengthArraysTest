//
//  ViewController.m
//  VariableLengthArraysTest
//
//  Created by Xcode Developer on 8/16/22.
//

#import "ViewController.h"

@implementation ViewController

static int c = 0;

static void (^(^(^(^(^array_pointer_test)(unsigned int))(CFTypeRef(^)(void)))(void(^)(CFTypeRef)))(CFTypeRef(^)(CFTypeRef)))(bool(^)(CFTypeRef)) = ^ (unsigned int object_count) {
    typedef CFTypeRef objects[object_count];
    typeof(objects) objects_ptr[object_count];
    __block unsigned long (^recursive_block)(unsigned long);
    (recursive_block = ^ unsigned long (unsigned long index) {
        printf("index == %lu\n", index);
        return (unsigned long)(index ^ 0UL) && (unsigned long)(recursive_block)(~-index);
    })(object_count);
    
    return ^ (CFTypeRef * objects_t) {
//        
//        __block void (^recurse)(void(^__strong)(CFTypeRef)) = ^{
//            __block unsigned long (^recursive_block)(unsigned long);
//            return ^ (void(^block)(CFTypeRef)) {
//                (recursive_block = ^ unsigned long (unsigned long index) {
//                    printf("index == %lu\t", index);
//                    block((objects_t + (index * sizeof(CFTypeRef))));
//                    return (unsigned long)(index ^ 0UL) && (unsigned long)recursive_block(~-index);
//                })(~-object_count);
//            };
//        }();
        
        return ^ (CFTypeRef(^write_object)(void)) {
            for (unsigned int index = 0; index < object_count; index++) {
                *((CFTypeRef *)objects_t + index) = CFBridgingRetain((__bridge id _Nullable)(write_object()));
                printf("Stored number_write = %lu\n", [(NSNumber *)((__bridge id)(*((CFTypeRef *)objects_t + index))) unsignedLongValue]);
            }
            return ^ (void(^read_object)(CFTypeRef)) {
                for (unsigned int index = 0; index < object_count; index++) {
                    read_object((*((CFTypeRef *)objects_t + index)));
                    printf("Stored number_read = %lu\n", [(NSNumber *)((__bridge id)(*((CFTypeRef *)objects_t + index))) unsignedLongValue]);
                }
                return ^ (CFTypeRef(^modify_object)(CFTypeRef)) {
                    for (unsigned int index = 0; index < object_count; index++) {
                        *((CFTypeRef *)objects_t + index) = CFBridgingRetain((__bridge id _Nullable)(modify_object((*((CFTypeRef *)objects_t + index)))));
                        printf("modified_number = %lu\n", [(NSNumber *)((__bridge id)(*((CFTypeRef *)objects_t + index))) unsignedLongValue]);
                    }
                    return ^ (bool(^filter_object)(CFTypeRef)) {
                        unsigned long unfiltered_object_count = object_count;
                        for (unsigned int index = 0; index < unfiltered_object_count; index++) {
                            CFTypeRef subject_object = (*((CFTypeRef *)objects_t + index));
                            (filter_object(subject_object)) ? ^{ printf("number %lu is odd\n", [(__bridge NSNumber *)subject_object unsignedLongValue]); (*((CFTypeRef *)objects_t + index) = CFBridgingRetain((__bridge id _Nullable)(subject_object))); }()
                            : ^ (unsigned int * object_count_t){ *object_count_t -= 1; }(&object_count);
                        }
                        array_pointer_test(object_count)(^ CFTypeRef {
                            __block NSNumber * number = [[NSNumber alloc] initWithUnsignedLong:c++];
                            printf("Sent number_write == %lu\n", [number unsignedLongValue]);
                            return (__bridge CFTypeRef)(number);
                        });
                        printf("modified object_count == %lu\n", object_count);
                    };
                };
            };
        };
    }(objects_ptr);
};


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
//    CFTypeRef (^retainable_object)(CFTypeRef(^)(void)) = ^ CFTypeRef (CFTypeRef(^object)(void)) {
//        return ^{
//            return object();
//        };
//    };
    
    
    array_pointer_test(10)(^ CFTypeRef {
        __block NSNumber * number = [[NSNumber alloc] initWithUnsignedLong:c++];
        printf("Sent number_write == %lu\n", [number unsignedLongValue]);
        return (__bridge CFTypeRef)(number);
    })(^ (CFTypeRef number) {
        printf("Returned number_read == %lu\n", [(__bridge NSNumber *)number unsignedLongValue]);
    })(^ CFTypeRef (CFTypeRef number) {
        number = (__bridge CFTypeRef)([[NSNumber alloc] initWithUnsignedLong:c++]);
        return (CFTypeRef)(number);
    })(^ bool (CFTypeRef number) {
        return ([(__bridge NSNumber *)number unsignedLongValue] % 2);
    });
    
}


@end


/*
 // --------------------
 typedef typeof(unsigned long (^)(unsigned long)) iterator;
 typedef typeof(CFTypeRef(^__strong)(const unsigned long)) mapper;
 typedef typeof(void(^)(void(^ _Nonnull __strong)(CFTypeRef))) applier;
 static void (^(^(^iterate_)(const unsigned long))(typeof(mapper)))(typeof(applier)) = ^ (const unsigned long iterations) {
 CFTypeRef obj_collection[iterations];
 return ^ (CFTypeRef obj_collection_t) {
 __block iterator integrand;
 return ^ (mapper map) {
 (integrand = ^ unsigned long (unsigned long index) {
 --index;
 *((CFTypeRef *)obj_collection_t + index) = (__bridge CFTypeRef)((__bridge id)(map(index)));
 return (unsigned long)(index ^ 0UL) && (unsigned long)(integrand)(index);
})(iterations);
return ^ (applier apply) {
    (integrand = ^ unsigned long (unsigned long index) {
        --index;
        //                    const id * button_t = (const id * const)CFBridgingRetain((__bridge id)((__bridge const void * _Nonnull)(*((id * const)obj_collection_t + index))));
        //                        apply(obj_collection_t + index);
        //                    apply((const id _Nonnull * _Nonnull const)(*((id * const)obj_collection_t + index)));
        return (unsigned long)(index ^ 0UL) && (unsigned long)(integrand)(index);
    })(iterations);
};
};
}(&obj_collection);
};

 */
