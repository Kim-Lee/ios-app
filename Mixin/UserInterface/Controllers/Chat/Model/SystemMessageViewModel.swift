import UIKit

class SystemMessageViewModel: MessageViewModel {

    static let backgroundImageHorizontalMargin: CGFloat = 76
    static let labelHorizontalInset: CGFloat = 16
    static let labelVerticalInset: CGFloat = 16
    static let attributes: [NSAttributedStringKey: Any] = {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        let attributes: [NSAttributedStringKey: Any] = [.font: UIFont.systemFont(ofSize: 14),
                                                        .paragraphStyle: paragraphStyle]
        return attributes
    }()
    
    let text: String
    
    private let textRect: CGRect
    
    override init(message: MessageItem, style: Style, fits layoutWidth: CGFloat) {
        text = SystemConversationAction.getSystemMessage(actionName: message.actionName, userId: message.userId, userFullName: message.userFullName, participantId: message.participantUserId, participantFullName: message.participantFullName, content: message.content)
        let sizeToFit = CGSize(width: layoutWidth - SystemMessageViewModel.backgroundImageHorizontalMargin,
                               height: UILayoutFittingExpandedSize.height)
        textRect = (text as NSString).boundingRect(with: sizeToFit,
                                                   options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                   attributes: SystemMessageViewModel.attributes,
                                                   context: nil)
        super.init(message: message, style: style, fits: layoutWidth)
        backgroundImage = #imageLiteral(resourceName: "ic_chat_bubble_system")
    }
    
    override func didSetStyle() {
        super.didSetStyle()
        cellHeight = textRect.height + SystemMessageViewModel.labelVerticalInset + bottomSeparatorHeight
    }
    
}
