package com.amigo.util;

import java.util.ArrayList;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
 
public class EchoHandler extends TextWebSocketHandler{
    
    //세션을 모두 저장한다.
    //방법 1 :  1:1 채팅
//	    private Map<String, WebSocketSession> sessions = new HashMap<String, WebSocketSession>();
    
    //방법 2 : 전체 채팅
    private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
    
    
    private static Logger logger = LoggerFactory.getLogger(EchoHandler.class);
    
    /**
     * 클라이언트 연결 이후에 실행되는 메소드
     */
    @Override
    public void afterConnectionEstablished(WebSocketSession session)
            throws Exception {
    	
        sessionList.add(session);
        
        logger.info("{} 연결됨", session.getPrincipal().getName());
    }
    
    /**
     * 클라이언트가 웹소켓 서버로 메시지를 전송했을 때 실행되는 메소드
     */
    @Override
    protected void handleTextMessage(WebSocketSession session,
            TextMessage message) throws Exception {
        
        //0번째에 session.getId() 1번째에 message.getPayload() 넣음
        logger.info("{}로 부터 {} 받음", session.getPrincipal().getName(), message.getPayload());
        
        for(WebSocketSession sess : sessionList){
            sess.sendMessage(new TextMessage( message.getPayload() ));
        }
        
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session,
            CloseStatus status) throws Exception {
    	
    	sessionList.remove(session);
        logger.info("{} 연결 끊김.", session.getPrincipal().getName());
    }

}
