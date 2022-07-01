import React from "react";
import cn from "./index.module.scss";

export interface ScrollableViewportProps extends React.PropsWithChildren {
  vertical?: boolean;
  horizontal?: boolean;
}

export const ScrollableViewport: React.FC<ScrollableViewportProps> = ({ children, vertical, horizontal }) => (
  <div className={[cn.container, vertical && cn.vertical, horizontal && cn.horizontal].filter(Boolean).join(" ")}>
    {children}
  </div>
);
