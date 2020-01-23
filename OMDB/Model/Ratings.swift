
import Foundation


struct Ratings : Decodable {
	let source : String?
	let value : String?

	enum CodingKeys: String, CodingKey {

		case source = "Source"
		case value = "Value"
	}

}
