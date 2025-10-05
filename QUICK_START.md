# 🚀 Quick Start Guide - IT Consulting Dashboard

## Get Up and Running in 5 Minutes!

### Step 1: Verify Installation ✅
You're already in the project directory. The application is fully set up and ready to use!

### Step 2: Start the Server 🖥️

```bash
rails server
```

The server will start on `http://localhost:3000`

### Step 3: Login 🔐

Open your browser and go to: **http://localhost:3000**

Use these credentials:

**Admin Account (Full Access)**
- Email: `admin@example.com`
- Password: `password123`

**Consultant Account**
- Email: `consultant1@example.com`
- Password: `password123`

**Client Account**
- Email: `john@techcorp.com`
- Password: `password123`

---

## 📱 Main Features to Explore

### 1. Dashboard (Main Page)
- View real-time KPIs
- See interactive charts
- Check recent tickets
- Monitor active alerts

### 2. Tickets
- Create new support tickets
- Assign tickets to consultants
- Track status: Open → In Progress → Resolved → Closed
- Add comments and updates
- Monitor SLA compliance

### 3. Clients
- Manage client organizations
- Set SLA parameters
- View client-specific metrics
- Track contract dates

### 4. Knowledge Base
- Search for solutions
- Create helpful articles
- Rate article helpfulness
- Browse by category

### 5. Alerts
- View active system alerts
- Check SLA breach warnings
- Resolve alerts

### 6. Reports
- Generate custom reports
- Filter by date range and client
- View analytics charts

---

## 🎯 Sample Data Included

The database has been seeded with:
- ✅ 3 client companies
- ✅ 30 sample tickets (various statuses)
- ✅ 15 knowledge base articles
- ✅ 8 active alerts
- ✅ 6 users (admin, consultants, clients)
- ✅ 25+ ticket comments
- ✅ 30 days of historical data for charts

---

## 🔄 Reset Database (Optional)

If you want to start fresh:

```bash
rails db:drop
rails db:create
rails db:migrate
rails db:seed
```

---

## 🛑 Stop the Server

Press `Ctrl+C` in the terminal where the server is running.

---

## 📊 Key Metrics You'll See

- **SLA Compliance**: Percentage of tickets resolved within SLA
- **MTTR**: Mean Time To Repair (average resolution time)
- **Uptime**: System availability percentage
- **Open vs Closed**: Ticket status distribution
- **Trends**: 30-day ticket creation chart

---

## 🎨 Dark Theme Colors

The dashboard uses a professional dark theme:
- Background: Dark charcoal (#0d1117)
- Accent: Neon blue (#58a6ff)
- Success: Terminal green (#7ee787)
- Alert: Red (#f85149)
- Warning: Orange (#ffa657)

---

## 💡 Tips

1. **Admin users** can see and manage everything
2. **Consultant users** can manage tickets and KB articles
3. **Client users** can view their own tickets and KB
4. Use the **search bar** on tickets and KB pages for quick filtering
5. Click on **charts** for more details (hover for exact numbers)
6. **SLA status** shows as green (within SLA) or red (breach)

---

## 🆘 Troubleshooting

### Server won't start?
```bash
# Kill any existing Rails processes
pkill -f 'rails server'

# Try starting again
rails server
```

### Database issues?
```bash
rails db:reset
rails db:seed
```

### Need to change admin password?
```bash
rails console
user = User.find_by(email: 'admin@example.com')
user.update(password: 'newpassword123')
exit
```

---

## 📚 Full Documentation

For complete documentation, see:
- **README.md** - Full setup and deployment guide
- **PROJECT_SUMMARY.md** - Technical implementation details

---

## 🎉 You're Ready!

Visit **http://localhost:3000** and start exploring the IT Consulting Dashboard!

---

**Happy Consulting! 🚀**
