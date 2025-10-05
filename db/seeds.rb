# Clean database
puts "Cleaning database..."
Comment.destroy_all
Alert.destroy_all
Ticket.destroy_all
KbArticle.destroy_all
User.destroy_all
Client.destroy_all

puts "Creating users..."
# Admin users
admin = User.create!(
  email: 'admin@example.com',
  password: 'password123',
  password_confirmation: 'password123',
  name: 'Bryan Martínez',
  role: :admin
)

# Personal admin user (only if credentials are provided via ENV)
if ENV['ADMIN_EMAIL'].present? && ENV['ADMIN_PASSWORD'].present?
  steven_admin = User.create!(
    email: ENV['ADMIN_EMAIL'],
    password: ENV['ADMIN_PASSWORD'],
    password_confirmation: ENV['ADMIN_PASSWORD'],
    name: 'Steven Martínez',
    role: :admin
  )
end

# Consultant users
consultant1 = User.create!(
  email: 'consultant1@example.com',
  password: 'password123',
  password_confirmation: 'password123',
  name: 'Sarah Johnson',
  role: :consultant
)

consultant2 = User.create!(
  email: 'consultant2@example.com',
  password: 'password123',
  password_confirmation: 'password123',
  name: 'Michael Chen',
  role: :consultant
)

puts "Creating clients..."
# Client companies
client1 = Client.create!(
  name: 'TechCorp Solutions',
  contact_email: 'contact@techcorp.com',
  contact_phone: '+1-555-0101',
  sla_response_time: 120,
  contract_start: 1.year.ago,
  contract_end: 1.year.from_now
)

client2 = Client.create!(
  name: 'Global Innovations Inc',
  contact_email: 'support@globalinnovations.com',
  contact_phone: '+1-555-0202',
  sla_response_time: 60,
  contract_start: 6.months.ago,
  contract_end: 18.months.from_now
)

client3 = Client.create!(
  name: 'StartupHub LLC',
  contact_email: 'hello@startuphub.com',
  contact_phone: '+1-555-0303',
  sla_response_time: 240,
  contract_start: 3.months.ago,
  contract_end: 9.months.from_now
)

puts "Creating client users..."
# Client users
client_user1 = User.create!(
  email: 'john@techcorp.com',
  password: 'password123',
  password_confirmation: 'password123',
  name: 'John Smith',
  role: :client_user,
  client: client1
)

client_user2 = User.create!(
  email: 'lisa@globalinnovations.com',
  password: 'password123',
  password_confirmation: 'password123',
  name: 'Lisa Anderson',
  role: :client_user,
  client: client2
)

client_user3 = User.create!(
  email: 'david@startuphub.com',
  password: 'password123',
  password_confirmation: 'password123',
  name: 'David Martinez',
  role: :client_user,
  client: client3
)

client_user4 = User.create!(
  email: 'emma@techcorp.com',
  password: 'password123',
  password_confirmation: 'password123',
  name: 'Emma Wilson',
  role: :client_user,
  client: client1
)

client_user5 = User.create!(
  email: 'alex@globalinnovations.com',
  password: 'password123',
  password_confirmation: 'password123',
  name: 'Alex Thompson',
  role: :client_user,
  client: client2
)

puts "Creating tickets..."
# Create tickets with various statuses and priorities
statuses = [:open, :in_progress, :resolved, :closed]
priorities = [:low, :medium, :high, :critical]
categories = [:incident, :request, :change, :problem]
consultants = [consultant1, consultant2]
clients = [client1, client2, client3]
creators = [client_user1, client_user2, client_user3, client_user4, client_user5, admin]

30.times do |i|
  days_ago = rand(30)
  status = statuses.sample
  resolved_at = (status == :resolved || status == :closed) ? rand(1..48).hours.ago : nil

  ticket = Ticket.create!(
    title: [
      "Email server not responding",
      "Slow network performance",
      "Application crashing on startup",
      "Database connection timeout",
      "VPN access issues",
      "Printer not working",
      "Software license renewal needed",
      "User account locked",
      "File sharing permission error",
      "Backup restoration request",
      "Security patch deployment",
      "System performance degradation",
      "Mobile app sync issues",
      "API endpoint timeout",
      "Cloud storage migration",
    ].sample + " - #{i + 1}",
    description: "Detailed description of the issue. The user has reported that #{['the system is not working as expected', 'there are intermittent failures', 'the application crashes frequently', 'performance has degraded significantly', 'access is being denied'].sample}. We need to investigate and resolve this as soon as possible.",
    status: status,
    priority: priorities.sample,
    category: categories.sample,
    client: clients.sample,
    created_by: creators.sample,
    assigned_to: rand > 0.3 ? consultants.sample : nil,
    created_at: days_ago.days.ago,
    resolved_at: resolved_at
  )
end

puts "Creating comments..."
# Add comments to some tickets
Ticket.limit(15).each do |ticket|
  rand(1..3).times do
    Comment.create!(
      ticket: ticket,
      user: [admin, consultant1, consultant2, ticket.created_by].sample,
      body: [
        "I'm looking into this issue now.",
        "Can you provide more details about when this started?",
        "This appears to be related to the recent update.",
        "I've identified the root cause and working on a fix.",
        "The issue has been resolved. Please verify.",
        "Escalating to senior engineer for review.",
        "Temporary workaround has been applied.",
        "This requires a system restart to complete the fix."
      ].sample,
      created_at: rand(1..10).hours.ago
    )
  end
end

puts "Creating KB articles..."
# Knowledge base articles
categories = ['Networking', 'Security', 'Hardware', 'Software', 'Cloud Services']

15.times do |i|
  KbArticle.create!(
    title: [
      "How to Reset Your Password",
      "VPN Connection Setup Guide",
      "Troubleshooting Network Connectivity",
      "Email Configuration on Mobile Devices",
      "Software Installation Best Practices",
      "Data Backup Procedures",
      "Security Best Practices for Remote Work",
      "Cloud Storage Access Guide",
      "Printer Configuration and Troubleshooting",
      "Application Performance Optimization",
      "Multi-Factor Authentication Setup",
      "File Sharing and Permissions",
      "System Backup and Recovery",
      "Network Drive Mapping",
      "Remote Desktop Connection Guide"
    ].sample + " - #{i + 1}",
    content: "This article provides detailed step-by-step instructions on how to resolve common issues.\n\n1. First, identify the problem by checking system logs\n2. Verify all connections and configurations\n3. Apply the recommended solution\n4. Test to ensure the issue is resolved\n5. Document the resolution for future reference\n\nIf problems persist after following these steps, please contact IT support for further assistance.",
    category: categories.sample,
    views_count: rand(10..500),
    helpful_count: rand(5..100),
    unhelpful_count: rand(0..20),
    created_at: rand(60).days.ago
  )
end

puts "Creating alerts..."
# Active alerts
alert_types = ['system_overload', 'sla_breach', 'security_warning', 'service_outage', 'high_priority_ticket']
severities = [:info, :warning, :critical]

8.times do
  Alert.create!(
    alert_type: alert_types.sample,
    message: [
      "System CPU usage has exceeded 90% threshold",
      "Multiple tickets are approaching SLA deadline",
      "Unusual login activity detected from foreign IP",
      "Disk space on server is running low",
      "Database backup failed last night",
      "Network latency increased by 200%",
      "Multiple failed authentication attempts detected",
      "Critical service is not responding"
    ].sample,
    severity: severities.sample,
    ticket: Ticket.all.sample,
    resolved: rand > 0.4,
    created_at: rand(1..48).hours.ago
  )
end

puts "Seed data created successfully!"
puts "\nLogin credentials:"
puts "Admin: admin@example.com / password123"
puts "Admin personal: #{ENV['ADMIN_EMAIL']} / [PROTECTED]" if ENV['ADMIN_EMAIL'].present?
puts "Consultant 1: consultant1@example.com / password123"
puts "Consultant 2: consultant2@example.com / password123"
puts "Client User: john@techcorp.com / password123"
