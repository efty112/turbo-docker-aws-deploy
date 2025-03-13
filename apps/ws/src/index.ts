import { WebSocketServer } from "ws";
import { prismaClient } from "db/client";

const server = new WebSocketServer({
    port: 3001
});

server.on("connection", async (socket) => {
    try {
        const userData = await prismaClient.user.create({
            data: {
                username: Math.random().toString(),
                password: Math.random().toString()
            }
        })
        console.log(userData)
    } catch (error) {
        console.log(error)
    }
    socket.send("Hi there you are connected to the server");
})