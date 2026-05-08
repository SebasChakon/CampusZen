package controlador;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class SecurityFilter implements Filter {

    private static final boolean USE_HTTPS = false;

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        if (USE_HTTPS && !req.isSecure()) {

            String url = "https://" + req.getServerName()
                    + ":8443"
                    + req.getRequestURI();

            if (req.getQueryString() != null) {
                url += "?" + req.getQueryString();
            }

            res.sendRedirect(url);
            return;
        }

        if (!USE_HTTPS && req.isSecure()) {

            String url = "http://" + req.getServerName()
                    + ":8080"
                    + req.getRequestURI();

            if (req.getQueryString() != null) {
                url += "?" + req.getQueryString();
            }

            res.sendRedirect(url);
            return;
        }

        chain.doFilter(request, response);
    }
}