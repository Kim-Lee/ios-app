import WCDBSwift

class MessageItem: TableCodable {

    static let jsonDecoder = JSONDecoder()
    
    var messageId: String = ""
    var conversationId: String = ""
    var userId: String = ""
    var category: String = ""
    var content = ""
    var mediaUrl: String? = nil
    var mediaMineType: String? = nil
    var mediaSize: Int64? = nil
    var mediaDuration: Int? = nil
    var mediaWidth: Int? = nil
    var mediaHeight: Int? = nil
    var mediaHash: String? = nil
    var mediaKey: Data? = nil
    var mediaDigest: Data? = nil
    var mediaStatus: String? = nil
    var thumbImage: String? = nil
    var status: String = ""
    var participantId: String? = nil
    var snapshotId: String? = nil
    var name: String? = nil
    var albumId: String? = nil
    var createdAt: String = ""

    var actionName: String? = nil

    var userFullName: String = ""
    var userIdentityNumber: String = ""

    var appId: String? = nil

    var snapshotAmount: String? = nil
    var snapshotAssetId: String? = nil
    var snapshotType: String = ""

    var participantFullName: String? = nil
    var participantUserId: String? = nil

    var assetUrl: String? = nil
    var assetSymbol: String? = nil
    var assetIcon: String? = nil
    var assetWidth: Int? = nil
    var assetHeight: Int? = nil

    var sharedUserId: String? = nil
    var sharedUserFullName: String = ""
    var sharedUserIdentityNumber: String = ""
    var sharedUserAvatarUrl: String = ""
    var sharedUserAppId: String = ""
    var sharedUserIsVerified: Bool = false

    var userIsBot: Bool {
        return !(appId?.isEmpty ?? true)
    }

    lazy var appButtons: [AppButtonData]? = {
        guard category == MessageCategory.APP_BUTTON_GROUP.rawValue, let data = Data(base64Encoded: content) else {
            return nil
        }
        return try? MessageItem.jsonDecoder.decode([AppButtonData].self, from: data)
    }()
    
    lazy var appCard: AppCardData? = {
        guard category == MessageCategory.APP_CARD.rawValue, let data = Data(base64Encoded: content) else {
            return nil
        }
        return try? MessageItem.jsonDecoder.decode(AppCardData.self, from: data)
    }()

    var isExtensionMessage: Bool {
        return category == MessageCategory.EXT_UNREAD.rawValue || category == MessageCategory.EXT_ENCRYPTION.rawValue
    }

    var isSystemMessage: Bool {
        return category == MessageCategory.SYSTEM_CONVERSATION.rawValue
    }

    init() {
        
    }

    enum CodingKeys: String, CodingTableKey {
        typealias Root = MessageItem
        case messageId = "id"
        case conversationId = "conversation_id"
        case userId = "user_id"
        case category
        case content
        case mediaUrl = "media_url"
        case mediaMineType = "media_mine_type"
        case mediaSize = "media_size"
        case mediaDuration = "media_duration"
        case mediaWidth = "media_width"
        case mediaHeight = "media_height"
        case mediaHash = "media_hash"
        case mediaKey = "media_key"
        case mediaDigest = "media_digest"
        case mediaStatus = "media_status"
        case thumbImage = "thumb_image"
        case status
        case participantId = "participant_id"
        case snapshotId = "snapshot_id"
        case name
        case albumId = "album_id"
        case createdAt = "created_at"

        case userFullName
        case userIdentityNumber

        case appId

        case participantFullName
        case participantUserId

        case snapshotAmount
        case snapshotAssetId
        case snapshotType

        case assetSymbol
        case assetIcon
        case assetWidth
        case assetHeight
        case assetUrl

        case actionName

        case sharedUserId
        case sharedUserFullName
        case sharedUserIdentityNumber
        case sharedUserAvatarUrl
        case sharedUserAppId
        case sharedUserIsVerified

        static let objectRelationalMapping = TableBinding(CodingKeys.self)
    }
}

extension MessageItem {

    static func createMessage(category: String, conversationId: String, createdAt: String) -> MessageItem {
        let message = MessageItem()
        message.messageId = UUID().uuidString.lowercased()
        message.status = MessageStatus.SENDING.rawValue
        message.category = category
        message.conversationId = conversationId
        message.createdAt = createdAt
        return message
    }

}
