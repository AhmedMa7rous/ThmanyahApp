//
//  ErrorView.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 18/08/2025.
//

import SwiftUI

struct ErrorView: View {
    let error: NetworkError
    let onRetry: () -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            errorIcon
            
            VStack(spacing: 12) {
                Text(errorTitle)
                    .font(.custom(FontNames.IBMPlexSansArabicBold, size: 20))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                Text(error.errorDescription ?? "حدث خطأ غير معروف")
                    .font(.custom(FontNames.IBMPlexSansArabicRegular, size: 14))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                
                if let suggestion = error.recoverySuggestion {
                    Text(suggestion)
                        .font(.custom(FontNames.IBMPlexSansArabicRegular, size: 14))
                        .foregroundColor(.orange.opacity(0.8))
                        .multilineTextAlignment(.center)
                }
            }
            
            Button(action: onRetry) {
                HStack(spacing: 8) {
                    Image(systemName: "arrow.clockwise")
                    Text("إعادة المحاولة")
                }
                .font(.custom(FontNames.IBMPlexSansArabicMedium, size: 16))
                .foregroundColor(.white)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(Color.orange)
                .cornerRadius(12)
            }
        }
        .padding(.horizontal, 40)
    }
    
    private var errorIcon: some View {
        Group {
            switch error {
            case .networkError, .timeout:
                Image(systemName: "wifi.exclamationmark")
                    .font(.system(size: 60))
                    .foregroundColor(.red)
            case .serverError:
                Image(systemName: "server.rack")
                    .font(.system(size: 60))
                    .foregroundColor(.orange)
            case .unauthorized, .forbidden:
                Image(systemName: "lock.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.yellow)
            case .notFound:
                Image(systemName: "questionmark.circle")
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
            default:
                Image(systemName: "exclamationmark.triangle")
                    .font(.system(size: 60))
                    .foregroundColor(.red)
            }
        }
    }
    
    private var errorTitle: String {
        switch error {
        case .networkError, .timeout:
            return "مشكلة في الاتصال"
        case .serverError:
            return "مشكلة في الخادم"
        case .unauthorized:
            return "غير مصرح"
        case .forbidden:
            return "ممنوع الوصول"
        case .notFound:
            return "المحتوى غير موجود"
        case .tooManyRequests:
            return "طلبات كثيرة"
        default:
            return "حدث خطأ"
        }
    }
}

#Preview {
    ErrorView(
        error: .networkError("فشل في الاتصال بالخادم"),
        onRetry: {}
    )
    .background(Color.black)
}
