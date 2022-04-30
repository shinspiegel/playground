import java.awt.BorderLayout;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JFrame;
import javax.swing.JPanel;

import Service.GradesService;
import UI.AppPanel;
import UI.AppTitle;
import UI.GradesPanel;
import UI.ResultLine;

public class App implements ActionListener {

    private GradesService gradeService = new GradesService();

    private JFrame appFrame = new JFrame();
    private JPanel appPanel = new JPanel();
    private AppPanel title = new AppTitle("Nota para o Atendimento");
    private AppPanel gradesPanel = new GradesPanel(this);
    private AppPanel gradeTitle = new AppTitle("NOTA ATUAL");
    private AppPanel gradeValue = new AppTitle("4.6");
    private ResultLine[] results = {
            new ResultLine("Quantidade de Votos 1"),
            new ResultLine("Quantidade de Votos 2"),
            new ResultLine("Quantidade de Votos 3"),
            new ResultLine("Quantidade de Votos 4"),
            new ResultLine("Quantidade de Votos 5"),
    };

    public App() {
        appPanel.setLayout(new GridLayout(9, 1));

        appPanel.add(title.getPanel());
        appPanel.add(gradesPanel.getPanel());
        appPanel.add(gradeTitle.getPanel());
        appPanel.add(gradeValue.getPanel());

        updateUI();

        for (ResultLine resultLine : results) {
            appPanel.add(resultLine.getPanel());
        }

        appFrame.add(appPanel, BorderLayout.CENTER);

        appFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        appFrame.setTitle("Sistema de Avaliação");
        appFrame.pack();
        appFrame.setVisible(true);
    }

    public static void main(String args[]) {
        new App();
    }

    public void actionPerformed(ActionEvent e) {
        Integer number = Integer.parseInt(e.getActionCommand());
        Integer index = number - 1;
        gradeService.incrementOn(index);
        updateUI();
    }

    public void updateUI() {
        gradeValue.setValue(gradeService.getAverage());

        for (int i = 0; i < gradeService.getGradesList().length; i++) {
            Integer value = gradeService.getGradesList()[i];
            results[i].setValue(String.valueOf(value));
        }
    }
}