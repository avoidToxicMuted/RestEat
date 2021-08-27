//
//  HAParamType.h
//  HiAnalytics
//
//  Created by cbg_bigdata on 2020/2/19.
//  Copyright © 2020 cbg_bigdata. All rights reserved.
//

#import <Foundation/Foundation.h>
///Store of the product added to favorites.
static NSString *const kHAParamStoreName = @"$StoreName";

///Brand of the product added to favorites.
static NSString *const kHAParamBrand = @"$Brand";

///Category of the product added to favorites.
static NSString *const kHAParamCategory = @"$Category";

///ID of the product added to the shopping cart.
static NSString *const kHAParamProductId = @"$ProductId";

///Name of the product added to the shopping cart.
static NSString *const kHAParamProductName = @"$ProductName";

///Features of the associated product.
static NSString *const kHAParamProductFeature = @"$ProductFeature";

///Product price.
static NSString *const kHAParamPrice = @"$Price";

///Number of products purchased by a user.
static NSString *const kHAParamQuantity = @"$Quantity";

///Revenue you receive through the transaction.
static NSString *const kHAParamRevenue = @"$Revenue";

///Revenue currency type. This parameter must be used with Revenue.
static NSString *const kHAParamCurrName = @"$CurrName";

///ID of the product location.
static NSString *const kHAParamPlaceId = @"$PlaceId";

///User destination for a hotel reservation.
static NSString *const kHAParamDestination = @"$Destination";

///User check-out date for a hotel reservation.
static NSString *const kHAParamEndDate = @"$EndDate";

///Number of days a user books for a hotel reservation.
static NSString *const kHAParamBookingDays = @"$BookingDays";

///Number of guests a user books for a hotel reservation.
static NSString *const kHAParamPassengersNumber = @"$PassengersNumber";

///Number of rooms a user books for a hotel reservation.
static NSString *const kHAParamBookingRooms = @"$BookingRooms";

///User departure location for a hotel reservation.
static NSString *const kHAParamOriginatingPlace = @"$OriginatingPlace";

///User check-in date for a hotel reservation.
static NSString *const kHAParamBeginDate = @"$BeginDate";

///Transaction ID generated by your transaction system.
static NSString *const kHAParamTransactionId = @"$TransactionId";

///Level of a room booked by a user for a hotel reservation.
static NSString *const kHAParamClass = @"$Class";

///ID generated by the ad network and used to record ad clicks.
static NSString *const kHAParamClickId = @"$ClickId";

///Name of a marketing activity.
static NSString *const kHAParamPromotionName = @"$PromotionName";

///Marketing content of a marketing activity.
static NSString *const kHAParamContent = @"$Content";

///Custom parameter.
static NSString *const kHAParamExtendParam = @"$ExtendParam";

///Name of the creative material used in a marketing activity.
static NSString *const kHAParamMaterialName = @"$MaterialName";

///ID of the slot where a creative material is displayed.
static NSString *const kHAParamMaterialSlot = @"$MaterialSlot";

///Type of the slot where a creative material is displayed, for example, the ad slot, operations slot, or banner..
static NSString *const kHAParamMaterialSlotType = @"$MaterialSlotType";

///Type of a marketing activity, for example, CPC or email.
static NSString *const kHAParamMedium = @"$Medium";

///ID of a marketing activity provider, for example, HUAWEI PPS.
static NSString *const kHAParamSource = @"$Source";

///Search string or keyword.
static NSString *const kHAParamKeywords = @"$Keywords";

///Check-out option entered by a user in the current check-out step.
static NSString *const kHAParamOption = @"$Option";

///Current step of a user in the check-out process.
static NSString *const kHAParamStep = @"$Step";

///Shipping fee generated for the transaction.
static NSString *const kHAParamVirtualCurrName = @"$VirtualCurrName";

///Departure date, hotel check-in date, or lease start date.
static NSString *const kHAParamVoucher = @"$Voucher";

///ID of the product location.
static NSString *const kHAParamPlace = @"$Place";

///Shipping fee generated for the transaction.
static NSString *const kHAParamShipping = @"$Shipping";

///Tax generated for the transaction.
static NSString *const kHAParamTaxFee = @"$TaxFee";

///ID of the user group that a user joins.
static NSString *const kHAParamUserGroupId = @"$UserGroupId";

///Name of a game level.
static NSString *const kHAParamLevelName = @"$LevelName";

///Operation result.
static NSString *const kHAParamResult = @"$Result";

///Role of a user.
static NSString *const kHAParamRoleName = @"$RoleName";

///Game level.
static NSString *const kHAParamLevelId = @"$LevelId";

///Details of the user's comment on an object.
static NSString *const kHAParamDetails = @"$Details";

///Evaluation details, commented object.
static NSString *const kHAParamCommentType = @"$CommentType";

///Indicates the particular method used in an operation. For example, facebook or email in the context of a sign-up or sign-in event.
static NSString *const kHAParamChannel = @"$Channel";

///Score in a game.
static NSString *const kHAParamScore = @"$Score";

///Search string or keyword.
static NSString *const kHAParamSearchKeywords = @"$SearchKeywords";

///Content type selected by a user.
static NSString *const kHAParamContentType = @"$ContentType";

///ID of an achievement.
static NSString *const kHAParamAchievementId = @"$AchievementId";

///Flight number generated by your transaction system.
static NSString *const kHAParamFlightNo = @"$FlightNo";

///Index of a product in the list.
static NSString *const kHAParamPositionId = @"$PositionId";

///Product list displayed to a user.
static NSString *const kHAParamProductList = @"$ProductList";

///User source.
static NSString *const kHAParamRegistMethod = @"$RegistMethod";

///Account type of a user, for example, email or mobile number.
static NSString *const kHAParamAcountType = @"$AcountType";

///Sign-in result.
static NSString *const kHAParamEvtResult = @"$EvtResult";

///Level before the change.
static NSString *const kHAParamPrevLevel = @"$PrevLevel";

///Current level.
static NSString *const kHAParamCurrvLevel = @"$CurrvLevel";

///Reason for changing or canceling an order.
static NSString *const kHAParamReason = @"$Reason";

///Names of vouchers applicable to a product.
static NSString *const kHAParamVouchers = @"$Vouchers";

///Product ID list.
static NSString *const kHAParamListId = @"$ListId";

///Filter condition.
static NSString *const kHAParamFilters = @"$Filters";

///Sorting condition.
static NSString *const kHAParamSorts = @"$Sorts";

///Order ID generated by your transaction system.
static NSString *const kHAParamOrderId = @"$OrderId";

///Payment mode selected by a user.
static NSString *const kHAParamPayType = @"$PayType";

///Expiration time of a voucher.
static NSString *const kHAParamExpireDate = @"$ExpireDate";

///Voucher type.
static NSString *const kHAParamVoucherType = @"$VoucherType";

///Type of a service provided for a user, for example, consultation or complaint.
static NSString *const kHAParamServiceType = @"$ServiceType";

/// Game duration.
static NSString *const kHAParamDuration = @"$Duration";

/// Top-up entry.
static NSString *const kHAParamPurchaseEntry = @"$PurchaseEntry";

/// Game level.
static NSString *const kHAParamLevel = @"$Level";

/// Entry.
static NSString *const kHAParamEntry = @"$Entry";

/// Props.
static NSString *const kHAParamProps = @"$Props";

/// TASKID.
static NSString *const kHAParamTaskId = @"$TaskId";

/// Inviter
static NSString *const kHAParamInviter = @"$Inviter";

/// User VIP level
static NSString *const kHAParamVIPLevel = @"$VIPLevel";

/// First sign-in
static NSString *const kHAParamFirstSignIn = @"$FirstSignIn";

/// Discount
static NSString *const kHAParamDiscount = @"$Discount";

/// First payment
static NSString *const kHAParamFirstPay = @"$FirstPay";

/// Total friends
static NSString *const kHAParamFriendNumber = @"$FriendNumber";

/// Group name
static NSString *const kHAParamUserGroupName = @"$UserGroupName";

/// Group level
static NSString *const kHAParamUserGroupLevel = @"$UserGroupLevel";

/// Total members
static NSString *const kHAParamMembers = @"$Members";

/// Level before upgrade
static NSString *const kHAParamLevelBefore = @"$LevelBefore";

/// Message type
static NSString *const kHAParamMessageType = @"$MessageType";

/// Role combat effectiveness
static NSString *const kHAParamRoleCombat = @"$RoleCombat";

/// Top level
static NSString *const kHAParamIsTopLevel = @"$IsTopLevel";

/// Occupation
static NSString *const kHAParamRoleClass = @"$RoleClass";

/// Skill name
static NSString *const kHAParamSkillName = @"$SkillName";

/// Skill level
static NSString *const kHAParamSkillLevel = @"$SkillLevel";

/// Level before learning
static NSString *const kHAParamSkillLevelBefore = @"$SkillLevelBefore";

/// Gear ID
static NSString *const kHAParamEquipmentId = @"$EquipmentId";

/// Gear name
static NSString *const kHAParamEquipmentName = @"$EquipmentName";

/// Gear level
static NSString *const kHAParamEquipmentLevel = @"$EquipmentLevel";

/// Occupation restrictions
static NSString *const kHAParamClassLimit = @"$ClassLimit";

/// Gear level restrictions
static NSString *const kHAParamLevelLimit = @"$LevelLimit";

/// Free
static NSString *const kHAParamIsFree = @"$IsFree";

/// Total gears
static NSString *const kHAParamTotalAfterChange = @"$TotalAfterChange";

/// Gear quality
static NSString *const kHAParamQuality = @"$Quality";

/// Enhancement type
static NSString *const kHAParamEnhanceType = @"$EnhanceType";

/// New occupation
static NSString *const kHAParamNewClass = @"$NewClass";

/// Old occupation
static NSString *const kHAParamOldClass = @"$OldClass";

/// Task type
static NSString *const kHAParamTaskType = @"$TaskType";

/// Task name
static NSString *const kHAParamTaskName = @"$TaskName";

/// Task bonus
static NSString *const kHAParamReward = @"$Reward";

/// Activity type
static NSString *const kHAParamActivityType = @"$ActivityType";

/// Activity name
static NSString *const kHAParamActivityName = @"$ActivityName";

/// Cutscene
static NSString *const kHAParamCutsceneName = @"$CutsceneName";

/// Pet ID
static NSString *const kHAParamPetId = @"$PetId";

/// Pet name
static NSString *const kHAParamPetDefaultName = @"$PetDefaultName";

/// Pet level
static NSString *const kHAParamPetLevel = @"$PetLevel";

/// Mount ID
static NSString *const kHAParamMountId = @"$MountId";

/// Mount name
static NSString *const kHAParamMountDefaultName = @"$MountDefaultName";

/// Mount level
static NSString *const kHAParamMountLevel = @"$MountLevel";

/// Server
static NSString *const kHAParamServer = @"$Server";

/// First role creation
static NSString *const kHAParamFirstCreate = @"$FirstCreate";

/// Gender
static NSString *const kHAParamRoleGender = @"$RoleGender";

/// Battle type
static NSString *const kHAParamBattleType = @"$BattleType";

/// Battle name
static NSString *const kHAParamBattleName = @"$BattleName";

/// Cards in battle
static NSString *const kHAParamNumberOfCards = @"$NumberOfCards";

/// Card list in battle
static NSString *const kHAParamCardList = @"$CardList";

/// Roles in battle
static NSString *const kHAParamParticipants = @"$Participants";

/// Battle difficulty
static NSString *const kHAParamDifficulty = @"$Difficulty";

/// MVP
static NSString *const kHAParamMVP = @"$MVP";

/// Battle damage
static NSString *const kHAParamDamage = @"$Damage";

/// Rankings
static NSString *const kHAParamRanking = @"$Ranking";

/// Dungeon
static NSString *const kHAParamDungeonName = @"$DungeonName";

/// Reason for earning
static NSString *const kHAParamWinReason = @"$WinReason";

/// Virtual balance
static NSString *const kHAParamBalance = @"$Balance";

/// Package type
static NSString *const kHAParamPackageType = @"$PackageType";

/// Item list
static NSString *const kHAParamItemList = @"$ItemList";

/// Gift type
static NSString *const kHAParamGiftType = @"$GiftType";

/// Gift name
static NSString *const kHAParamGiftName = @"$GiftName";

/// Old value
static NSString *const kHAParamOldValue = @"$OldValue";

/// New value
static NSString *const kHAParamNewValue = @"$NewValue";

/// Video type
static NSString *const kHAParamVideoType = @"$VideoType";

/// Video ID
static NSString *const kHAParamVideoName = @"$VideoName";

/// Message title
static NSString *const kHAParamMessageTitle = @"$MessageTitle";

/// Response
static NSString *const kHAParamOperation = @"$Operation";

/// Drawings
static NSString *const kHAParamNumberOfDrawing = @"$NumberOfDrawing";

/// Left pulls for a guaranteed character/item
static NSString *const kHAParamLeftPullsForGuarantee = @"$LeftPullsForGuarantee";

/// Role power
static NSString *const kHAParamCombat = @"$Combat";

/// Virtual coins
static NSString *const kHAParamAmount = @"$Amount";

/// Member type
static NSString *const kHAParamVIPType = @"$VIPType";

/// Member status
static NSString *const kHAParamVIPStatus = @"$VIPStatus";

/// Member validity period
static NSString *const kHAParamVIPExpireDate = @"$VIPExpireDate";

/// Entry
static NSString *const kHAParamEnter = @"$Enter";

/// Effective date
static NSString *const kHAParamStartDate = @"$StartDate";

/// Validity period
static NSString *const kHAParamEffectiveTime = @"$EffectiveTime";

/// Practice name
static NSString *const kHAParamName = @"$Name";

/// Practice mode
static NSString *const kHAParamMode = @"$Mode";

/// Subject
static NSString *const kHAParamSubject = @"$Subject";

/// Accuracy
static NSString *const kHAParamAccuracy = @"$Accuracy";

/// Content duration
static NSString *const kHAParamContentLength = @"$ContentLength";

/// Description
static NSString *const kHAParamRemark = @"$Remark";

/// Name
static NSString *const kHAParamContentName = @"$ContentName";

/// Section
static NSString *const kHAParamSection = @"$Section";

/// Consecutive check-in days
static NSString *const kHAParamDays = @"$Days";

/// Post ID
static NSString *const kHAParamPostId = @"$PostId";

/// Operation type
static NSString *const kHAParamType = @"$Type";

/// Information
static NSString *const kHAParamInformation = @"$Information";

/// Information type
static NSString *const kHAParamInformationType = @"$InformationType";
