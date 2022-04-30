package UI;

import java.awt.GridLayout;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JPanel;

public class GradeButton implements AppPanel {
    private JPanel panel = new JPanel();
    private JButton button = new JButton();
    private JLabel label = new JLabel();

    public GradeButton(String text) {
        button.setText(text);
        panel.setLayout(new GridLayout(1, 1));
        panel.add(button);
    }

    public GradeButton(String text, String description) {
        button.setText(text);
        label.setText(description);

        panel.setLayout(new GridLayout(2, 1));
        panel.add(button);
        panel.add(label);
    }

    public void addListener(ActionListener listener) {
        button.addActionListener(listener);
    }

    public JPanel getPanel() {
        return panel;
    }

    public void setValue(String value) {
    }
}
