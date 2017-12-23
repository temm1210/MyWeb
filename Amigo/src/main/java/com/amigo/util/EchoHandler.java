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
    
    //������ ��� �����Ѵ�.
    //��� 1 :  1:1 ä��
//	    private Map<String, WebSocketSession> sessions = new HashMap<String, WebSocketSession>();
    
    //��� 2 : ��ü ä��
    private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
    
    
    private static Logger logger = LoggerFactory.getLogger(EchoHandler.class);
    
    /**
     * Ŭ���̾�Ʈ ���� ���Ŀ� ����Ǵ� �޼ҵ�
     */
    @Override
    public void afterConnectionEstablished(WebSocketSession session)
            throws Exception {
    	
        sessionList.add(session);
        
        logger.info("{} �����", session.getPrincipal().getName());
    }
    
    /**
     * Ŭ���̾�Ʈ�� ������ ������ �޽����� �������� �� ����Ǵ� �޼ҵ�
     */
    @Override
    protected void handleTextMessage(WebSocketSession session,
            TextMessage message) throws Exception {
        
        //0��°�� session.getId() 1��°�� message.getPayload() ����
        logger.info("{}�� ���� {} ����", session.getPrincipal().getName(), message.getPayload());
        
        for(WebSocketSession sess : sessionList){
            sess.sendMessage(new TextMessage( message.getPayload() ));
        }
        
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session,
            CloseStatus status) throws Exception {
    	
    	sessionList.remove(session);
        logger.info("{} ���� ����.", session.getPrincipal().getName());
    }

}
