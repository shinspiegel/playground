package UI;

import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.SpringLayout;

public class ResultLine implements AppPanel {
    private JPanel resultPanel = new JPanel();
    private JLabel label = new JLabel();
    private JTextField textField = new JTextField();

    public ResultLine(String text) {
        SpringLayout layout = new SpringLayout();
        layout.putConstraint(SpringLayout.WEST, label, 6, SpringLayout.WEST, resultPanel);
        layout.putConstraint(SpringLayout.NORTH, label, 6, SpringLayout.NORTH, resultPanel);
        layout.putConstraint(SpringLayout.WEST, textField, 6, SpringLayout.EAST, label);
        layout.putConstraint(SpringLayout.NORTH, textField, 6, SpringLayout.NORTH, resultPanel);
        layout.putConstraint(SpringLayout.EAST, resultPanel, 6, SpringLayout.EAST, textField);
        layout.putConstraint(SpringLayout.SOUTH, resultPanel, 6, SpringLayout.SOUTH, textField);

        resultPanel.setLayout(layout);

        label.setText(text);

        resultPanel.add(label);
        resultPanel.add(textField);
    }

    public JPanel getPanel() {
        return resultPanel;
    }

    public void setValue(String value) {
        textField.setText(value);
    }
}
