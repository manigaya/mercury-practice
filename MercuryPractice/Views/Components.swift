import SwiftUI

/// A circle with the first letter of the name, used instead of merchant logos.
struct InitialsIcon: View {
    let name: String
    var size: CGFloat = 40

    var body: some View {
        Text(String(name.prefix(1)))
            .font(.system(size: size * 0.45, weight: .semibold))
            .foregroundStyle(.white)
            .frame(width: size, height: size)
            .background(Color.indigo.gradient)
            .clipShape(Circle())
    }
}

/// A small coloured pill: "Pending", "Failed" or "Posted".
struct StatusBadge: View {
    let status: Transaction.Status

    var body: some View {
        Text(status.label)
            .font(.caption2.weight(.semibold))
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .foregroundStyle(status.color)
            .background(status.color.opacity(0.15))
            .clipShape(Capsule())
    }
}

extension Transaction.Status {
    var label: String { rawValue.capitalized }

    var color: Color {
        switch self {
        case .posted: .gray
        case .pending: .orange
        case .failed: .red
        }
    }
}

struct BalanceHeader: View {
    let account: Account

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(account.name)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Text(account.availableBalance, format: .currency(code: "USD"))
                .font(.largeTitle.bold())
            Text("Available balance")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    VStack(spacing: 20) {
        InitialsIcon(name: "Stripe")
        HStack {
            StatusBadge(status: .posted)
            StatusBadge(status: .pending)
            StatusBadge(status: .failed)
        }
    }
}
