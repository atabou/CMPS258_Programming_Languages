
import java.util.*;
import java.lang.Math;

class Audio {
    private int numSamples;
    private float sampleRate;
    Audio(int s, float sps) {
        numSamples = s;
        sampleRate = sps;
    }
    public float plabackTime() {
        return numSamples/sampleRate;
    }
}

class Video {
    private int numFrames;
    private float frameRate;
    Video(int f, float fps) {
        numFrames = f;
        frameRate = fps;
    }
    public float plabackTime() {
        return numFrames/frameRate;
    }
}

public class Main {

    public static void main(String[] args) {
        // Do not modify the test code below
        List<Audio> audioList = new ArrayList<Audio>() {{
            add(new Audio(100000, 44100.0f));
            add(new Audio(250000, 43200.0f));
            add(new Audio(250000, 50000.0f));
            add(new Audio(300000, 36400.0f));
        }};
        List<Video> videoList = new ArrayList<Video>() {{
            add(new Video(200, 24.0f));
            add(new Video(500, 25.0f));
            add(new Video(500, 30.0f));
            add(new Video(500, 24.0f));
            add(new Video(700, 25.0f));
        }};
        // Test selectRandom
        Audio a = selectRandom(audioList);
        Video v = selectRandom(videoList);
        // Test playbackTimeWithSpeed
        System.out.println(playbackTimeWithSpeed(a, 1.25f));
        System.out.println(playbackTimeWithSpeed(v, 1.50f));
        // Test totalPlaybackTime
        System.out.println(totalPlaybackTime(audioList));
        System.out.println(totalPlaybackTime(videoList));
    }

}
