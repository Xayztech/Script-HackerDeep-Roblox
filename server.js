const express = require('express');
const path = require('path');
const fs = require('fs');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.urlencoded({ extended: true }));

app.get('/', (req, res) => {
    const userAgent = req.headers['user-agent'] || '';

    // Cek apakah pengunjung adalah Browser (Web)
    if (userAgent.includes('Mozilla') || userAgent.includes('Chrome') || userAgent.includes('Safari') || userAgent.includes('Edge')) {
        // Gunakan process.cwd() agar Vercel bisa menemukan filenya
        res.sendFile(path.join(process.cwd(), 'index.html'));
    } else {
        // Jika pengunjung bukan browser (yaitu Executor)
        try {
            // Gunakan process.cwd() untuk mencari file Lua
            const lokasiFileLua = path.join(process.cwd(), 'XayzPanelLiteV2.lua');
            
            const isiScriptLua = fs.readFileSync(./XayzPanelLiteV2.lua, 'utf8');
            
            res.type('text/plain').send(isiScriptLua);
            
        } catch (error) {
            console.error("Gagal membaca file Lua:", error);
            res.status(500).send('print("Error dari Server Vercel: File script tidak ditemukan!")');
        }
    }
});

// Rute Login
app.post('/login', (req, res) => {
    const username = req.body.username;
    const password = req.body.password;

    if (username === 'admin' && password === 'rahasia123') {
        res.send('<h1>Login Berhasil!</h1><p>Ini adalah dashboard rahasia kamu.</p>');
    } else {
        res.send('<h1>Login Gagal!</h1> <a href="/">Kembali</a>');
    }
});

// Penyesuaian khusus Vercel: Export app agar bisa dibaca sebagai Serverless Function
module.exports = app;

// Server tetap bisa dijalankan di komputer lokal untuk testing (npm start)
if (require.main === module) {
    app.listen(PORT, () => {
        console.log(`Server berjalan di http://localhost:${PORT}`);
    });
  }
