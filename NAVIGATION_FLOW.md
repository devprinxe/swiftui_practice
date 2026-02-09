# Navigation Flow Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                         App Launch                               │
└─────────────────────────────────────────────────────────────────┘
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                      SplashView                                  │
│                   (2 second animation)                           │
└─────────────────────────────────────────────────────────────────┘
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                      WelcomeView                                 │
│                  ┌─────────────────┐                            │
│                  │  Login Button   │──┐                         │
│                  └─────────────────┘  │                         │
│                  ┌─────────────────┐  │                         │
│                  │ Register Button │──┤                         │
│                  └─────────────────┘  │                         │
└──────────────────────────────────────┼─────────────────────────┘
                                        ▼
                        ┌───────────────────────────┐
                        │                           │
                ┌───────▼─────────┐        ┌───────▼──────────┐
                │   LoginView     │        │  RegisterView    │
                │                 │◄───────┤                  │
                │  - Email        │        │  - Full Name     │
                │  - Password     │────────►  - Email         │
                │  - Login Button │        │  - Password      │
                └────────┬────────┘        │  - Confirm Pass  │
                         │                 │  - Register Btn  │
                         │                 └────────┬─────────┘
                         │                          │
                         └──────────┬───────────────┘
                                    ▼
                          (Authentication Success)
                                    ▼
┌─────────────────────────────────────────────────────────────────┐
│                       MainTabView                                │
│  ┌────────────┬────────────────┬─────────────────────────┐     │
│  │            │                │                         │     │
│  ▼            ▼                ▼                         │     │
│  Home Tab     List Tab         Account Tab              │     │
└──────────────────────────────────────────────────────────┘     │
       │            │                │                            │
       │            │                │                            │
┌──────▼──────┐ ┌──▼──────────┐ ┌───▼──────────────┐           │
│  HomeView   │ │PostListView │ │  AccountView     │           │
│             │ │             │ │                  │           │
│ ┌─────────┐ │ │ ┌─────────┐ │ │ - User Profile  │           │
│ │ User    │ │ │ │ Post    │ │ │ - Contact Info  │           │
│ │ Header  │ │ │ │ List    │ │ │ - Company Info  │           │
│ └─────────┘ │ │ └────┬────┘ │ │ - Address       │           │
│             │ │      │      │ │                  │           │
│ ┌─────────┐ │ │      │      │ │ ┌──────────────┐│           │
│ │ Post    │─┼─┼──────┼──────┼─┼─┤Logout Button ││           │
│ │ Feed    │ │ │      │      │ │ └──────┬───────┘│           │
│ └────┬────┘ │ │      │      │ │        │        │           │
│      │      │ │      │      │ │        │        │           │
└──────┼──────┘ └──────┼──────┘ └────────┼────────┘           │
       │                │                 │                    │
       │                │                 │                    │
       └────────┬───────┘                 │                    │
                │                         │                    │
                ▼                         ▼                    │
     ┌──────────────────────┐    (Back to WelcomeView)       │
     │  PostDetailView      │                                 │
     │                      │                                 │
     │  - Full Title        │                                 │
     │  - Author Card       │                                 │
     │  - Full Body         │                                 │
     │  - Back Button       │                                 │
     └──────────────────────┘                                 │
```

## State Flow

```
AppRouter State Machine:
────────────────────────

showSplash: true  ──(2s timer)──► showSplash: false
                                   isAuthenticated: false
                                           │
                                           ▼
                                   WelcomeView shown
                                           │
                                    (User logs in)
                                           │
                                           ▼
                                   isAuthenticated: true
                                   currentUserId: 1
                                           │
                                           ▼
                                   MainTabView shown
                                   activeTab: home
                                           │
                                    (User navigates)
                                           │
                                           ▼
                            ┌──────────────┼──────────────┐
                            │              │              │
                         Home.path    List.path    Account.path
                            │              │              │
                     [postDetail(5)]      []        [editProfile]
```

## Per-Tab Navigation Independence

```
Home Tab Navigation Stack:
┌─────────────────────┐
│ HomeView            │ ← Root
├─────────────────────┤
│ PostDetail(id: 1)   │ ← Pushed
├─────────────────────┤
│ PostDetail(id: 5)   │ ← Pushed
└─────────────────────┘

List Tab Navigation Stack:
┌─────────────────────┐
│ PostListView        │ ← Root
└─────────────────────┘

Account Tab Navigation Stack:
┌─────────────────────┐
│ AccountView         │ ← Root
└─────────────────────┘

Each tab maintains its own NavigationPath!
Switching tabs preserves navigation state.
```
