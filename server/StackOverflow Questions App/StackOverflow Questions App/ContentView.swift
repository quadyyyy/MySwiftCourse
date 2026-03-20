//
//  ContentView.swift
//  StackOverflow Questions App
//
//  Created by Куприянов Тимофей on 07.03.2026.
//

import SwiftUI
import Combine

enum StackOverflowError: Error {
    case invalidURL
    case invalidData
    case invalidResponse
    case decodingFailed
    case failedToFetch
}


// MARK: - DTOs


struct QuestionsResponseDTO: Decodable {
    let items: [QuestionDTO]
    let hasMore: Bool
    let quotaRemaining: Int

    enum CodingKeys: String, CodingKey {
        case items
        case hasMore       = "has_more"
        case quotaRemaining = "quota_remaining"
    }
}


struct QuestionDTO: Decodable {
    let title: String
    let viewCount: Int
    let answerCount: Int
    let score: Int
    let owner: OwnerDTO
    let link: URL

    enum CodingKeys: String, CodingKey {
        case title
        case viewCount   = "view_count"
        case answerCount = "answer_count"
        case score
        case owner
        case link
    }
}


struct OwnerDTO: Decodable {
    let displayName: String
    let profileImage: URL?

    enum CodingKeys: String, CodingKey {
        case displayName  = "display_name"
        case profileImage = "profile_image"
    }
}

// MARK: - Mappers

extension QuestionDTO {
    func toDomain() -> Question {
        Question(
            title: title,
            viewCount: viewCount,
            answerCount: answerCount,
            score: score,
            owner: owner.toDomain(),
            link: link
        )
    }
}

extension OwnerDTO {
    func toDomain() -> Owner {
        Owner(
            displayName: displayName,
            profileImageURL: profileImage
        )
    }
}

// MARK: - Domain models

public struct Owner: Equatable, Hashable {
    public let displayName: String
    public let profileImageURL: URL?
}

public struct Question: Identifiable, Equatable, Hashable {
    public var id: URL { link }
    public let title: String
    public let viewCount: Int
    public let answerCount: Int
    public let score: Int
    public let owner: Owner
    public let link: URL
}

// MARK: - Service
class NetworkService {
    func request(_ endpoint: String) async throws -> Data {
        guard let url = URL(string: "https://api.stackexchange.com/" + endpoint) else { throw StackOverflowError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw StackOverflowError.invalidResponse
        }
            
        guard !data.isEmpty else {
            throw StackOverflowError.invalidData
        }
            
        return data

    }
}

private class Decoder {
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()

    func decode(_ data: Data) throws -> [Question] {
        do {
            let response = try jsonDecoder.decode(QuestionsResponseDTO.self, from: data)
            return response.items.map { $0.toDomain() }
        } catch {
            throw StackOverflowError.decodingFailed
        }
    }
}


// MARK: - Functionality
@MainActor
final class QuestionsViewModel: ObservableObject {
    @Published var questions: [Question] = []
    @Published var isLoading = false
    @Published var error: StackOverflowError? = nil

    private let network = NetworkService()
    private let decoder = Decoder()

    func fetchQuestions() async {
        isLoading = true
        defer { isLoading = false }
        do {
            let data = try await network.request("2.3/questions?page=1&pagesize=10&order=asc&sort=activity&site=stackoverflow") // <- здесь вообще по-хорошему прописывать параметры надо, а не тупо url
            questions = try decoder.decode(data)
        } catch let e as StackOverflowError {
            error = e
        } catch {
            self.error = .failedToFetch
        }
    }
}

struct QuestionRowView: View {
    let question: Question
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(question.title)
                .font(.headline)
            HStack(spacing: 5) {
                Image(systemName: "arrowshape.up")
                Text("\(question.score)")
                
                Image(systemName: "eye")
                Text("\(question.viewCount)")
                
                Image(systemName: "ellipsis.message")
                Text("\(question.answerCount)")
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .padding(.vertical, 4)
    }
}

struct ContentView: View {
    @StateObject var vm = QuestionsViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("StackOverflow Questions")
                    .font(.title)
                    .bold()
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)
            ZStack {
                List(vm.questions) { question in
                    Link(destination: question.link) {
                        QuestionRowView(question: question)
                    }
                }
                .scrollContentBackground(.hidden)
                if vm.isLoading {
                    VStack {
                        Text("Loading...")
                            .bold()
                        ProgressView()
                    }
                }
            }
        }
        .task {
            await vm.fetchQuestions()
        }
        .alert("Error", isPresented: Binding(
            get: { vm.error != nil },
            set: { _ in vm.error = nil }
        )) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(vm.error?.localizedDescription ?? "")
        }
    }
}

#Preview {
    ContentView()
}

