package UI;

import java.awt.FlowLayout;
import java.awt.event.ActionListener;

import javax.swing.JPanel;

public class GradesPanel implements AppPanel {
    private JPanel gradesPanel = new JPanel();
    private JPanel gradesNumbersPanel = new JPanel();
    private GradeButton[] buttons = {
            new GradeButton("1", "Péssimo"),
            new GradeButton("2"),
            new GradeButton("3"),
            new GradeButton("4"),
            new GradeButton("5", "Excelente")
    };

    public GradesPanel(ActionListener listener) {
        FlowLayout fl = new FlowLayout();
        fl.setAlignOnBaseline(true);
        gradesNumbersPanel.setLayout(fl);

        for (GradeButton gradeButton : buttons) {
            gradeButton.addListener(listener);
            gradesNumbersPanel.add(gradeButton.getPanel());
        }

        gradesPanel.add(gradesNumbersPanel);
    }

    public JPanel getPanel() {
        return gradesPanel;
    }

    public void setValue(String value) {
    }
}
