const express = require('express');
const http = require('http');
const Binance = require('binance-api-node').default;
const { Server } = require('socket.io');
const Redis = require('ioredis');
const { type } = require('os');
const app = express();
const port = 3000;



const server = http.createServer(app);
const io = new Server(server, {
    cors: {
        origin: "http://14.225.207.166:5173",
        methods: ["GET", "POST"],
        credentials: true
    }
});

app.get('/', (req, res) => {
    res.send('Hello World!');
});

server.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`);
});

const redis = new Redis();

redis.on('connect', () => {
    console.log('Connected to Redis');
});

redis.on('error', (err) => {
    console.log('Redis error: ', err);
});



// Thiết lập một kết nối duy nhất đến Binance
const tickers = ['BTCUSDT', 'ETHUSDT', 'XRPUSDT', 'BNBUSDT', 'MATICUSDT', 'SOLUSDT', 'DOGEUSDT', 'TRXUSDT', 'BLZUSDT', 'USDCUSDT', 'LEVERUSDT', 'LTCUSDT'];
// Thiết lập lại kết nối với Binance

async function setupBinanceConnection() {
    console.log('Setting up Binance connection...');
    const client = Binance();
    const ws = client.ws.ticker(tickers, tickerHandler);
    setInterval(async ()=>{  
      console.log(  await  client.ping())
    },180000)
    // ws.on('open', () => {
    //     console.log('WebSocket connection opened.');
    // });

   
}

const tickerHandler = (ticker) => {
    io.emit('ticker', ticker);

};

setupBinanceConnection();
io.on('connection', (socket) => {
    console.log('Client connected: ' + socket.id);
    socket.on('disconnect', () => {
        console.log('Client disconnected:' + socket.id);
    });

    socket.on('updateUserInfo', (data) => {
        getUserInfo(data, socket)

    });
    socket.on('error', (error) => {
        console.log('Socket.IO error: ', error);
    });




});
async function getUserInfo(userData, socket) {
    try {
        // Lấy tất cả các trường của hash "user:username"
        const userInfo = await redis.hgetall(`user:${userData.username}`);
       
        if (Object.keys(userInfo).length === 0) {
            console.log(`No user found with username: ${userData.username}`);
        } else {
            const curentSocket = userInfo.socketId;
            if (userData.token !== userInfo.token) {
                console.log('token khac nhau');
                userInfo.token = userData.token;
                userInfo.socketId = socket.id;
            } else {
                userInfo.socketId = socket.id;
            }
            socket.to(curentSocket).emit('notify', {
                type: 'loginError',
                code: 100,
                message: 'You have been logged out from another location. Please log in again.'
            });
            await redis.hmset(`user:${userData.username}`, userInfo);
        }
    } catch (error) {
        console.error('Error getting user info from Redis:', error);
    }
}