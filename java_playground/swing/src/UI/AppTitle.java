package UI;

import javax.swing.JLabel;
import javax.swing.JPanel;

public class AppTitle implements AppPanel {
    private JPanel titlePanel = new JPanel();
    private JLabel title = new JLabel();

    public AppTitle(String text) {
        title.setText(text);
        titlePanel.add(title);
    }

    public JPanel getPanel() {
        return titlePanel;
    }

    public void setValue(String value) {
        title.setText(value);
    }
}
