

import Foundation


struct MoviesDetailsResponseModel : Decodable {
	let title : String?
	let year : String?
	let rated : String?
	let released : String?
	let runtime : String?
	let genre : String?
	let director : String?
	let writer : String?
	let actors : String?
	let plot : String?
	let language : String?
	let country : String?
	let awards : String?
	let poster : String?
	let ratings : [Ratings]?
	let metascore : String?
	let imdbRating : String?
	let imdbVotes : String?
	let imdbID : String?
	let type : String?
	let totalSeasons : String?
	let response : String?

	enum CodingKeys: String, CodingKey {

		case title = "Title"
		case year = "Year"
		case rated = "Rated"
		case released = "Released"
		case runtime = "Runtime"
		case genre = "Genre"
		case director = "Director"
		case writer = "Writer"
		case actors = "Actors"
		case plot = "Plot"
		case language = "Language"
		case country = "Country"
		case awards = "Awards"
		case poster = "Poster"
		case ratings = "Ratings"
		case metascore = "Metascore"
		case imdbRating = "imdbRating"
		case imdbVotes = "imdbVotes"
		case imdbID = "imdbID"
		case type = "Type"
		case totalSeasons = "totalSeasons"
		case response = "Response"
	}

}
