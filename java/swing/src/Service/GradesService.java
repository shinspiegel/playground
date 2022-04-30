package Service;

public class GradesService {
    private Integer[] grades = { 0, 0, 0, 0, 0 };

    public String getAverage() {
        double total = 0;

        for (int i = 0; i < grades.length; i++) {
            total += (grades[i] * (i + 1));
        }

        total = total / (double) grades.length;

        return String.format("%.1f", total);
    }

    public void incrementOn(Integer index) {
        grades[index]++;
    }

    public Integer[] getGradesList() {
        return grades;
    }
}
