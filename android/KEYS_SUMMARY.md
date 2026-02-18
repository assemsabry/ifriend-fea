# IFriend App - Keys Summary for Social Login
Generated on: December 27, 2025

---

## 🔐 DEBUG KEYSTORE
**Location**: `C:\Users\abdal\.android\debug.keystore`
**Password**: android
**Alias**: androiddebugkey

### Debug SHA1:
```
A7:4C:32:9B:3F:30:85:73:B0:2F:6F:03:58:34:A1:9B:85:50:56:FC
```

### Debug SHA256:
```
09:98:9D:15:1D:16:64:4B:C7:0D:BE:38:B3:2D:D1:81:AC:E2:D5:C1:46:4C:B8:FC:0C:6C:DC:07:F2:2A:55:F4
```

### Debug Facebook Hash Key:
```
p0wymz8whXOwL28DWDShm4VQVvw=
```

---

## 🚀 RELEASE KEYSTORE
**Location**: `C:\Users\abdal\StudioProjects\ifriend_app\android\app-release.jks`
**Password**: IFriend2025Secure
**Alias**: ifriend-release

### Release SHA1:
```
51:99:E8:E3:7B:53:B1:66:5A:93:C9:B1:24:3D:29:17:A8:D9:A6:29
```

### Release SHA256:
```
9F:05:E4:88:50:AD:4D:FC:60:C7:7C:D9:74:81:29:A7:47:15:BD:79:1E:3D:40:F5:D1:2B:A2:32:05:8B:91:15
```

### Release Facebook Hash Key:
```
UZno43tTsWZak8mxJD0pF6jZpik=
```

---

## 📱 FACEBOOK CONFIGURATION

### Go to: https://developers.facebook.com/apps
1. Select your app
2. Settings > Basic
3. Android Platform Settings
4. Add BOTH hash keys in "Key Hashes":

```
p0wymz8whXOwL28DWDShm4VQVvw=
UZno43tTsWZak8mxJD0pF6jZpik=
```

---

## 🔍 GOOGLE CONFIGURATION

### Go to: https://console.cloud.google.com/
1. Select your project
2. APIs & Services > Credentials
3. OAuth 2.0 Client IDs > Android
4. Add BOTH SHA1 fingerprints:

**Debug SHA1:**
```
A7:4C:32:9B:3F:30:85:73:B0:2F:6F:03:58:34:A1:9B:85:50:56:FC
```

**Release SHA1:**
```
51:99:E8:E3:7B:53:B1:66:5A:93:C9:B1:24:3D:29:17:A8:D9:A6:29
```

**Package Name:** `com.ifriend.app`

---

## ⚠️ IMPORTANT NOTES

1. **Add BOTH debug and release keys** to Facebook and Google
2. **Keep keystore file safe** - backup to secure location
3. **Never share passwords** or commit keystore to git
4. **Wait 1-2 minutes** after adding keys for changes to propagate

---

## 🔧 FIREBASE CONFIGURATION (if needed)

If using Firebase, also add SHA1 and SHA256 to Firebase Console:
1. Go to: https://console.firebase.google.com/
2. Project Settings > General
3. Your apps > Android app
4. Add both SHA fingerprints (Debug & Release)

---

Generated automatically by Antigravity
