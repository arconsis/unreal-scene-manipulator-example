package com.example.plugins

package com.arconcis.plugins

import io.ktor.http.*
import io.ktor.serialization.kotlinx.*
import io.ktor.server.application.*
import io.ktor.server.routing.*
import io.ktor.server.websocket.*
import io.ktor.util.collections.*
import io.ktor.websocket.*
import kotlinx.serialization.json.Json
import java.time.Duration
import java.util.concurrent.atomic.AtomicInteger

fun Application.configureSockets() {
    install(WebSockets) {
        pingPeriod = Duration.ofSeconds(45)
        timeout = Duration.ofSeconds(1200)
        maxFrameSize = Long.MAX_VALUE
        masking = false
        contentConverter = KotlinxWebsocketSerializationConverter(Json)
    }
    routing {
        val connections = ConcurrentSet<Connection>()

        webSocket("/ws") {
            val connection = Connection(this)
            connections += connection

            try {
                for (message in incoming) {
                    message as? Frame.Text ?: continue
                    connections.forEach {
                        it.session.send(message)
                    }
                }
            } catch (t: Throwable) {
                println(t.localizedMessage)
            } finally {
                println("onClose: ${closeReason.await()}")
                connections -= connection
            }
        }
    }
}


class Connection(val session: DefaultWebSocketSession) {
    companion object {
        val lastId = AtomicInteger(0)
    }

    val name = "user${lastId.getAndIncrement()}"
}