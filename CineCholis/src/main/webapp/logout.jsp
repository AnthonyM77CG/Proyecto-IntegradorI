<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Invalida la sesión si está activa
    if (session != null) {
        session.invalidate();
    }
%>
